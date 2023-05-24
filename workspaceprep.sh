#!/bin/bash

cwd_cmakelists="
CMAKE_MINIMUM_REQUIRED(VERSION 3.19)\n
PROJECT(test)\n
\n
SET(CMAKE_BUILD_TYPE \"Debug\")\n
SET(CMAKE_CXX_STANDARD 14)\n
SET(EXECUTABLE_OUTPUT_PATH \${PROJECT_SOURCE_DIR}/bin)\n
SET(LIBRARY_OUTPUT_PATH \${PROJECT_SOURCE_DIR}/runtimelib)\n
\n
# find all include directories\n
MACRO(FIND_HEADER_DIRECTORIES return_list)\n
    FILE(GLOB_RECURSE new_list *.h)\n
    SET(dir_list "")\n
    FOREACH(file_path \${new_list})\n
        GET_FILENAME_COMPONENT(dir_path \${file_path} PATH)\n
        SET(dir_list \${dir_list} \${dir_path})\n
    ENDFOREACH()\n
    LIST(REMOVE_DUPLICATES dir_list)\n
    SET(\${return_list} \${dir_list})\n
ENDMACRO()\n
FIND_HEADER_DIRECTORIES(return_list)\n
INCLUDE_DIRECTORIES(\${return_list})\n
# additional include,  so that when you include  some header\n
# you could just enter file name, or you can enter the whole\n
# path or part of the path to indicate the header file.\n
INCLUDE_DIRECTORIES(\${PROJECT_SOURCE_DIR}/include)\n
MESSAGE(\"------------------- HEAD LIST -------------------\")\n
FOREACH(header_path \${return_list})\n
    MESSAGE(\"\${header_path}\")\n
ENDFOREACH()\n
MESSAGE(\"------------------- LSIT  END -------------------\")\n

LINK_DIRECTORIES(\${PROJECT_SOURCE_DIR}/lib)\n
LINK_DIRECTORIES(\${PROJECT_SOURCE_DIR}/runtimelib)\n
OPTION(DEBUG \"debug switch\" OFF)
OPTION(GEN_SHARED_LIB \"generate shared lib .so\" OFF)\n
OPTION(GEN_STATIC_LIB \"generate static lib .a\" ON)\n
\n
ADD_SUBDIRECTORY(\${PROJECT_SOURCE_DIR}/src)\n
ADD_SUBDIRECTORY(\${PROJECT_SOURCE_DIR}/app)\n
"

app_cmakelists="
AUX_SOURCE_DIRECTORY(. APP_LIST)\n
\n
IF (DEBUG)\n
    ADD_DEFINITIONS(-DDEBUG)\n
    MESSAGE(\"DEBUG set to ON\")\n
ENDIF()\n
\n
FILE(GLOB LIB_LIST \${PROJECT_SOURCE_DIR}/lib/*.dll \${PROJECT_SOURCE_DIR}/lib/*.a)\n
IF (LIB_LIST)\n
    MESSAGE(\"------------------- LIB LIST -------------------\")\n
    FOREACH (lib \${LIB_LIST})\n
        MESSAGE(\"lib found: \${lib}\")\n
    ENDFOREACH ()\n
    MESSAGE(\"------------------- LIST END -------------------\")\n
ENDIF()\n
\n
FOREACH (app \${APP_LIST})\n
    GET_FILENAME_COMPONENT(output \${app} NAME_WE)\n
    ADD_EXECUTABLE(\${output} \${app})\n
\tIF(USE_SELF_LIB)\n
        TARGET_LINK_LIBRARIES(\${output} mysrc)\n
\tENDIF()\n
\n
    SET(to_be_linked \"\")\n
    IF (LIB_LIST)\n
        FOREACH (lib \${LIB_LIST})\n
            GET_FILENAME_COMPONENT(lib_name \${lib} NAME_WE)\n
            GET_FILENAME_COMPONENT(lib_post \${lib} LAST_EXT)\n
            IF (NOT lib_post)\n
                MESSAGE(FATAL_ERROR \"lib format not recognized\\n\")\n
            ENDIF()\n
            IF (NOT(lib_post STREQUAL \".a\" OR lib_post STREQUAL \".so\" OR lib_post STREQUAL \".lib\" OR lib_post STREQUAL \".dll\"))\n
                MESSAGE(FATAL_ERROR \"lib format not recognized: \${lib_post}\\n\")\n
            ENDIF()\n
            STRING(SUBSTRING \${lib_name} 3 -1 lib_name_without_prefix)\n
            SET(to_be_linked \${to_be_linked} \${lib_name_without_prefix})\n
            TARGET_LINK_LIBRARIES(\${output} \${lib_name_without_prefix})\n
        ENDFOREACH()\n
        MESSAGE(\"\${output} will be linked with: \${to_be_linked}\")\n
    ENDIF()\n
ENDFOREACH()\n
"

src_cmakelists="
FILE(GLOB_RECURSE SRC_LIST \${PROJECT_SOURCE_DIR}/src/*.cpp \${PROJECT_SOURCE_DIR}/src/*.c)\n
\n
IF(DEBUG)\n
    ADD_DEFINITIONS(-DDEBUG)\n
ENDIF()\n
\n
IF(SRC_LIST)\n
    IF(GEN_STATIC_LIB)\n
        ADD_LIBRARY(mysrc STATIC \${SRC_LIST})\n
    ENDIF()\n
    IF(GEN_SHARED_LIB)\n
        ADD_LIBRARY(mysrc SHARED \${SRC_LIST})\n
    ENDIF()\n
\tSET(USE_SELF_LIB 1 PARENT_SCOPE)\n
ENDIF()\n
\n
MESSAGE(\"------------------- SRC LIST -------------------\")\n
\n
FOREACH(src \${SRC_LIST})\n
    MESSAGE(\"\${src}\")\n
ENDFOREACH()\n
\n
MESSAGE(\"------------------- LIST END -------------------\")\n
"

read -p "specify a path :" path
if  [ ! -n "$path" ] ;then
    echo "didn't choose the path, will create in current working dir..."
    path=$(pwd)
else
    echo "template will be generated in $path"
fi

if  [ ! -n "$path" ] ;then
    exit -1
fi

mkdir $path/app
mkdir $path/src
mkdir $path/bin
mkdir $path/lib
mkdir $path/runtimelib
mkdir $path/include
mkdir $path/build


echo -e $cwd_cmakelists > $path/CMakeLists.txt
echo -e $app_cmakelists > $path/app/CMakeLists.txt
echo -e $src_cmakelists > $path/src/CMakeLists.txt

# for vscode workspace settings
launch_json="
{\n
\t// 使用 IntelliSense 了解相关属性。  \n
\t// 悬停以查看现有属性的描述。 \n
\t// 欲了解更多信息，请访问: https://go.microsoft.com/fwlink/?linkid=830387 \n
\t\"version\": \"0.2.0\",\n
\t\"configurations\": [\n
\t\t{\n
\t\t\t\"name\": \"mingw32-make.exe - 生成和调试活动文件\",\n
\t\t\t\"type\": \"cppdbg\",\n
\t\t\t\"request\": \"launch\",\n
\t\t\t\"program\": \"\${fileDirname}/../bin/\${fileBasenameNoExtension}\",\n
\t\t\t\"args\": [],\n
\t\t\t\"stopAtEntry\": false,\n
\t\t\t\"cwd\": \"\${fileDirname}\",\n
\t\t\t\"environment\": [],\n
\t\t\t\"externalConsole\": false,\n
\t\t\t\"MIMode\": \"gdb\",\n
\t\t\t\"miDebuggerPath\": \"/usr/bin/gdb\",\n
\t\t\t\"setupCommands\": [\n
\t\t\t\t{\n
\t\t\t\t\t\"description\": \"为 gdb 启用整齐打印\",\n
\t\t\t\t\t\"text\": \"-enable-pretty-printing\",\n
\t\t\t\t\t\"ignoreFailures\": true\n
\t\t\t\t}\n
\t\t\t],\n
\t\t\t\"preLaunchTask\": \"C/C++: 生成活动文件\"\n
\t\t}\n
\t]\n
}\n
"

task_json="
{\n
\t// 有关 tasks.json 格式的文档，请参见\n
\t// https://go.microsoft.com/fwlink/?LinkId=733558\n
\t\"version\": \"2.0.0\",\n
\t\"options\": {\n
\t\t\"cwd\": \"\${workspaceFolder}/build\"\n
\t},\n
\t\"tasks\": [\n
\t\t{\n
\t\t\t\"type\": \"shell\",\n
\t\t\t\"label\": \"cmake\",\n
\t\t\t\"command\": \"cmake\",\n
\t\t\t\"args\": [\n
\t\t\t\t\"..\"\n
\t\t\t]\n
\t\t},\n
\t\t{\n
\t\t\t\"label\": \"make\",\n
\t\t\t\"group\": {\n
\t\t\t\t\"kind\": \"build\",\n
\t\t\t\t\"isDefault\": true\n
\t\t\t},\n
\t\t\t\"command\": \"make\",\n
\t\t\t\"args\": []\n
\t\t},\n
\t\t{\n
\t\t\t\"label\": \"C/C++: 生成活动文件\",\n
\t\t\t\"dependsOn\": [\n
\t\t\t\t\"cmake\",\n
\t\t\t\t\"make\"\n
\t\t\t]\n
\t\t}\n
\t]\n
}\n
"

mkdir $path/.vscode
echo $launch_json > $path/.vscode/launch.json
echo $task_json > $path/.vscode/tasks.json 