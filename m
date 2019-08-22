Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6B8D98908
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2019 03:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfHVBg0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Aug 2019 21:36:26 -0400
Received: from mail-eopbgr1310125.outbound.protection.outlook.com ([40.107.131.125]:6126
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727887AbfHVBgZ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Aug 2019 21:36:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2Jixci5QSD/bBnDKFKIU9YZJtCeSxvzQJan3zCFSsSW4zWw9Uc357IAdGGpSEE247r+qFb17QxrJ8MoSnUbXQJWWxS+pO+0/Mva/Pwm3RFO7kyo1fWP/K8l+sXH+JBwXcQnWoN4feVoiEtk+NYWXJj+QVtcFkgcFOKKWJtc7gkoQiLh1PfQw5Fghc1yy3q3SthXUhGsQlLFdDwJ3Icqepxslf4yn4ztIqH4kFlf08P38jKp8/4/kSKuETlex8HrRsuEyGsHt+pXx7pVkTsUE91U7oE0a8V4Qn73pifC3KZQnplsctmIru5L2OIYlu3u+/jOh0SDRgk2HoUItVHFYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vv6slgDpP38OtVEE71pnL2RHbbrPEx6pREfnrTHu+qw=;
 b=Rj/A3acjhha8ghlUc81mXV0fUGJIq4P6zDIWWh8JaFcyYVyM1bVkZerXDL5ZsejmIvIbHhqgTZuv97SzSPhMYh7c+00gFC5FFw4fpv1ZBHxCrplTOwie1RdPUxhEj1PGfFdVJfeeYWmN88wTHRJJgxMbN06rrOdHQiI2oR7HA/Gz2mxQzIdWtKifJ3y2wYvF/Ezs+z2jJEXY4EdoBjc0tncKHSSWvtui7GZAO5ToLUgmgK9D/8wn3tEx2WT2zD3tfnV+iGqLq9uik+Gx+7yEGj/PXKC3Lt98mLq06WOW1U/SoM40YnXuCQqadXog9VFsxVst71nz0qCkQgHbUv68Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vv6slgDpP38OtVEE71pnL2RHbbrPEx6pREfnrTHu+qw=;
 b=ilkl3NERCPwR57xTJsEe0wIcqcNNLyJ5tLUlDqJjR/4ERlvwf4NdLDZgxIaX0fGD5FSQe0ayiCYVYztuzxAEtP46zHlGZgTbhsgZZCmcBxI5l9k2uWWQBDDaKhe//GwYx2WH0HzbfOcf4ivvzQaeXi6ZE7VfWFQP8IhYxCKbhR4=
Received: from PS1P15301MB0249.APCP153.PROD.OUTLOOK.COM (10.255.65.22) by
 PS1P15301MB0348.APCP153.PROD.OUTLOOK.COM (10.255.67.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.1; Thu, 22 Aug 2019 01:36:09 +0000
Received: from PS1P15301MB0249.APCP153.PROD.OUTLOOK.COM
 ([fe80::549e:77f4:711:5218]) by PS1P15301MB0249.APCP153.PROD.OUTLOOK.COM
 ([fe80::549e:77f4:711:5218%6]) with mapi id 15.20.2220.000; Thu, 22 Aug 2019
 01:36:09 +0000
From:   Harry Zhang <harz@microsoft.com>
To:     brandonbonaby94 <brandonbonaby94@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>
CC:     brandonbonaby94 <brandonbonaby94@gmail.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Harry Zhang <harz@microsoft.com>
Subject: RE: [PATCH v3 3/3] tools: hv: add vmbus testing tool
Thread-Topic: [PATCH v3 3/3] tools: hv: add vmbus testing tool
Thread-Index: AQHVV7CeHHGaxJHemk+y+54kjswJNKcGXC+A
Date:   Thu, 22 Aug 2019 01:36:09 +0000
Message-ID: <PS1P15301MB02497E19A17D71913DA32857C0A50@PS1P15301MB0249.APCP153.PROD.OUTLOOK.COM>
References: <cover.1566340843.git.brandonbonaby94@gmail.com>
 <c63cae8e916cbfa4a3fe627da3a545736d0b45dc.1566340843.git.brandonbonaby94@gmail.com>
In-Reply-To: <c63cae8e916cbfa4a3fe627da3a545736d0b45dc.1566340843.git.brandonbonaby94@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=harz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-22T01:36:04.8254244Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0b35747b-9995-425a-aa5e-beaf039546dc;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=harz@microsoft.com; 
x-originating-ip: [2001:4898:80e8:8:d0a9:79dc:5a3b:f957]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa8b63b8-862c-4f55-8392-08d726a11be6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PS1P15301MB0348;
x-ms-traffictypediagnostic: PS1P15301MB0348:|PS1P15301MB0348:|PS1P15301MB0348:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PS1P15301MB0348896AE36106745E7F25CBC0A50@PS1P15301MB0348.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(396003)(136003)(366004)(346002)(376002)(13464003)(199004)(189003)(486006)(476003)(52536014)(76116006)(81156014)(66946007)(2501003)(6246003)(33656002)(99286004)(446003)(30864003)(46003)(66446008)(11346002)(64756008)(66556008)(66476007)(7736002)(305945005)(1511001)(53946003)(8676002)(74316002)(81166006)(53546011)(6506007)(102836004)(5660300002)(53936002)(186003)(8936002)(86362001)(25786009)(6436002)(110136005)(2906002)(6116002)(4326008)(22452003)(55016002)(229853002)(316002)(54906003)(9686003)(256004)(10290500003)(14454004)(10090500001)(8990500004)(71190400001)(71200400001)(14444005)(76176011)(7696005)(478600001)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:PS1P15301MB0348;H:PS1P15301MB0249.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NMtpXnKr6phCpvVdnQhMWgLRs9tfV5AsXf75VSJqSsGX2nWHxs0KEDmrCeOgAgTyVrM2OWpWcW/Afo0kEukWsDKhYd/8c0gV3b71I+okL/pEDScsIkjWFPFqyv8SkAZ5afmLixL6lE6rtkFmTDI7S97lloxjFTXBmOgW0BlGPeYKKM3Dy8GqIiQ46iTR/lkOA5bFtQ8s2C02VbuatoXmubG2oMqbB9pNw9W9xDes0IBaJV+1vGQdvtHZnuzE1VDEL2BnPF5Wa29hYv7zu70Ogkd1GrxbSsjHy4oeuyB/cxssA4h8sTN8eLLZb9mRlITDOcUGNlT5FSBlAXtNx3fkvhyJQ+0r1GT5NqUehopdPGTXBoe4UsPAvMN02bMBYVvYVG3LBE1L290AJh8L5JnhM8N1/pO+gCWyAEyBuUI8etU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8b63b8-862c-4f55-8392-08d726a11be6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 01:36:09.2268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F03NPXyB5pICuSmbD4KIB8uWQLp/ssx+JLMLpfD6pFI5Ctlljl3z+kbL66/XjpE5V6kirmWmq6H7ynzJTfKl6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1P15301MB0348
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Tool function issues:  Please validate args errors for  '-p' and '--path', =
 in or following validate_args_path(). =20

Comments of functionality:
-	it's confusing when fuzz_testing are all OFF, then user run ' python3 /ho=
me/lisa/vmbus_testing -p /sys/kernel/debug/hyperv/000d3a6e-4548-000d-3a6e-4=
548000d3a6e delay -d 0 0 -D ' which will enable all delay testing state ('Y=
' in state files).  even I used "-D", "--dis_all" param.=20
-	if we have subparsers of "disable-all" for the testing tool, then probabl=
y we don't need the mutually_exclusive_group under subparsers of "delay"
-	the path argument (-p) could be an argument for subparsers of "delay" and=
 "view" only.

Regards,
Harry

-----Original Message-----
From: linux-hyperv-owner@vger.kernel.org <linux-hyperv-owner@vger.kernel.or=
g> On Behalf Of Branden Bonaby
Sent: Tuesday, August 20, 2019 4:40 PM
To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.co=
m>; Stephen Hemminger <sthemmin@microsoft.com>; sashal@kernel.org
Cc: brandonbonaby94 <brandonbonaby94@gmail.com>; linux-hyperv@vger.kernel.o=
rg; linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] tools: hv: add vmbus testing tool

This is a userspace tool to drive the testing. Currently it supports introd=
ucing user specified delay in the host to guest communication path on a per=
-channel basis.

Signed-off-by: Branden Bonaby <brandonbonaby94@gmail.com>
---
Changes in v3:
 - Align python tool to match Linux coding style.

Changes in v2:
 - Move testing location to new location in debugfs.

 tools/hv/vmbus_testing | 342 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 342 insertions(+)
 create mode 100644 tools/hv/vmbus_testing

diff --git a/tools/hv/vmbus_testing b/tools/hv/vmbus_testing new file mode =
100644 index 000000000000..0f249f6ee698
--- /dev/null
+++ b/tools/hv/vmbus_testing
@@ -0,0 +1,342 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Program to allow users to fuzz test Hyper-V drivers # by interfacing=20
+with Hyper-V debugfs directories # author: Branden Bonaby
+
+import os
+import cmd
+import argparse
+from collections import defaultdict
+from argparse import RawDescriptionHelpFormatter
+
+# debugfs paths for vmbus must exist (same as in lsvmbus)=20
+debugfs_sys_path =3D "/sys/kernel/debug/hyperv"
+if not os.path.isdir(debugfs_sys_path):
+        print("{} doesn't exist/check permissions".format(debugfs_sys_path=
))
+        exit(-1)
+# Do not change unless, you change the debugfs attributes # in=20
+"/sys/kernel/debug/hyperv/<UUID>/". All fuzz testing # attributes will=20
+start with "fuzz_test".
+pathlen =3D len(debugfs_sys_path)
+fuzz_state_location =3D "fuzz_test_state"
+fuzz_states =3D {
+        0 : "Disable",
+        1 : "Enable"
+}
+
+fuzz_methods =3D {
+        1 : "Delay_testing"
+}
+
+fuzz_delay_types =3D {
+        1 : "fuzz_test_buffer_interrupt_delay",
+        2 : "fuzz_test_message_delay"
+}
+
+def parse_args():
+        parser =3D argparse.ArgumentParser(description =3D "vmbus_testing =
"
+                "[-s] [0|1] [-q] [-p] <debugfs-path>\n""vmbus_testing [-s]=
"
+                " [0|1] [-q][-p] <debugfs-path> delay [-d] [val][val] [-E|=
-D]\n"
+                "vmbus_testing [-q] disable-all\n"
+                "vmbus_testing [-q] view [-v|-V]\n"
+                "vmbus_testing --version",
+                epilog =3D "Current testing options {}".format(fuzz_method=
s),
+                prog =3D 'vmbus_testing',
+                formatter_class =3D RawDescriptionHelpFormatter)
+        subparsers =3D parser.add_subparsers(dest =3D "action")
+        parser.add_argument("--version", action =3D "version",
+                        version =3D '%(prog)s 1.0')
+        parser.add_argument("-q","--quiet", action =3D "store_true",
+                        help =3D "silence none important test messages")
+        parser.add_argument("-s","--state", metavar =3D "", type =3D int,
+                        choices =3D range(0, 2),
+                        help =3D "Turn testing ON or OFF for a single devi=
ce."
+                        " The value (1) will turn testing ON. The value"
+                        " of (0) will turn testing OFF with the default se=
t"
+                        " to (0).")
+        parser.add_argument("-p","--path", metavar =3D "",
+                        help =3D "Refers to the debugfs path to a vmbus de=
vice."
+                        " If the path is not a valid path to a vmbus devic=
e,"
+                        " the program will exit. The path must be the"
+                        " absolute path; use the lsvmbus command to find"
+                        " the path.")
+        parser_delay =3D subparsers.add_parser("delay",
+                        help =3D "Delay buffer/message reads in microsecon=
ds.",
+                        description =3D "vmbus_testing -s [0|1] [-q] -p "
+                        "<debugfs-path> delay -d "
+                        "[buffer-delay-value] [message-delay-value]\n"
+                        "vmbus_testing [-q] delay [buffer-delay-value] "
+                                "[message-delay-value] -E\n"
+                        "vmbus_testing [-q] delay [buffer-delay-value] "
+                                "[message-delay-value] -D",
+                        formatter_class =3D RawDescriptionHelpFormatter)
+        delay_group =3D parser_delay.add_mutually_exclusive_group()
+        delay_group.add_argument("-E", "--en_all", action =3D "store_true"=
,
+                        help =3D "Enable Buffer/Message Delay testing on A=
LL"
+                        " devices. Use -d option with this to set the valu=
es"
+                        " for both the buffer delay and the message delay.=
 No"
+                        " value can be (0) or less than (-1). If testing i=
s"
+                        " disabled on a device prior to running this comma=
nd,"
+                        " testing will be enabled on the device as a resul=
t"
+                        " of this command.")
+        delay_group.add_argument("-D", "--dis_all", action =3D "store_true=
",
+                        help =3D "Disable Buffer/Message delay testing on =
ALL"
+                        " devices. A  value equal to (-1) will keep the"
+                        " current delay value, and a value equal to (0) wi=
ll"
+                        " remove delay testing for the specfied delay colu=
mn."
+                        " only values (-1) and (0) will be accepted but at=
"
+                        " least one value must be a (0) or a (-1).")
+        parser_delay.add_argument("-d", "--delay_time", metavar =3D "", na=
rgs =3D 2,
+                        type =3D check_range, default =3D [0, 0], required=
 =3D (True),
+                        help =3D "Buffer/message delay time. A value of (0=
) will"
+                        "disable delay testing on the specified delay colu=
mn,"
+                        " while a value of (-1) will ignore the specified"
+                        " delay column. The default values are [0] & [0]."
+                        " The first column represents the buffer delay val=
ue"
+                        " and the second represents the message delay valu=
e."
+                        " Value constraints: -1 <=3D value <=3D 1000.")
+        parser_dis_all =3D subparsers.add_parser("disable-all",
+                        help =3D "Disable ALL testing on all vmbus devices=
.",
+                        description =3D "vmbus_testing disable-all",
+                        formatter_class =3D RawDescriptionHelpFormatter)
+        parser_view =3D subparsers.add_parser("view",
+                        help =3D "View testing on vmbus devices.",
+                        description =3D "vmbus_testing view -V\n"
+                        "vmbus_testing -p <debugfs-path> view -v",
+                        formatter_class =3D RawDescriptionHelpFormatter)
+        view_group =3D parser_view.add_mutually_exclusive_group()
+        view_group.add_argument("-V", "--view_all", action =3D "store_true=
",
+                        help =3D "View the test status for all vmbus devic=
es.")
+        view_group.add_argument("-v", "--view_single", action =3D "store_t=
rue",
+                        help =3D "View test values for a single vmbus=20
+device.")
+
+        return  parser.parse_args()
+
+# value checking for range checking input in parser def=20
+check_range(arg1):
+        try:
+                val =3D int(arg1)
+        except ValueError as err:
+                raise argparse.ArgumentTypeError(str(err))
+        if val < -1 or val > 1000:
+                message =3D ("\n\nExpected -1 <=3D value <=3D 1000, got va=
lue"
+                            " {}\n").format(val)
+                raise argparse.ArgumentTypeError(message)
+        return val
+
+def main():
+        try:
+                dev_list =3D []
+                for dir in os.listdir(debugfs_sys_path):
+                        dev_list.append(os.path.join(debugfs_sys_path, dir=
))
+                #key value, pairs
+                #key =3D debugfs device path
+                #value =3D list of fuzz testing attributes.
+                dev_files =3D defaultdict(list)
+                for dev in dev_list:
+                        path =3D os.path.join(dev, "delay")
+                        for f in os.listdir(path):
+                                if (f.startswith("fuzz_test")):
+                                        dev_files[path].append(f)
+
+                dev_files.default_factory =3D None
+                args =3D parse_args()
+                path =3D args.path
+                state =3D args.state
+                quiet =3D args.quiet
+                if (not quiet):
+                        print("*** Use lsvmbus to get vmbus device type"
+                                " information.*** ")
+                if (state is not None and validate_args_path(path, dev_lis=
t)):
+                        if (state is not get_test_state(path)):
+                                change_test_state(path, quiet)
+                        state =3D get_test_state(path)
+                if (state =3D=3D 0 and path is not None):
+                        disable_testing_single_device(path, 0, quiet)
+                        return
+                #Use subparsers as the key for different fuzz testing meth=
ods
+                if (args.action =3D=3D "delay"):
+                        delay =3D args.delay_time
+                        if (validate_delay_values(args, delay)):
+                                delay_test_all_devices(dev_list, delay, qu=
iet)
+                        elif (validate_args_path(path, dev_list)):
+                                if(get_test_state(path) =3D=3D 1):
+                                        delay_test_store(path, delay, quie=
t)
+                                        return
+                                print("device testing OFF, use -s 1 to tur=
n ON")
+                elif (args.action =3D=3D "disable-all"):
+                        disable_all_testing(dev_list, quiet)
+                elif (args.action =3D=3D "view"):
+                        if (args.view_all):
+                                all_devices_test_status(dev_list)
+                        elif (args.view_single):
+                                if (validate_args_path(path, dev_list)):
+                                        device_test_values(dev_files, path=
)
+                                        return
+                                print("Error,(check path) usage: -p"\
+                                            " <debugfs device path> view -=
v")
+        except AttributeError:
+                print("check usage, 1 or more elements not provided")
+                exit(-1)
+
+# Validate delay values to make sure they are acceptable to # to either=20
+enable all delays on a device or disable all # delays on a device def=20
+validate_delay_values(args, delay):
+        if (args.en_all):
+                for i in delay:
+                        if (i < -1 or i =3D=3D 0):
+                                print("\nError, Values must be"
+                                        " equal to -1 or be > 0, use"
+                                        " -d option")
+                                exit(-1)
+                return True
+        elif (args.dis_all):
+                for i in delay:
+                        if (i < -1 or i > 0):
+                                print("\nError, at least 1 value"
+                                        " is not a (0) or a (-1)")
+                                exit(-1)
+                return True
+        else:
+                return False
+
+
+# Validate argument path
+def validate_args_path(path, dev_list):
+        if (path in dev_list):
+                return True
+        else:
+                return False
+
+# display Testing status of single device def=20
+device_test_values(dev_files, path):
+
+        delay_path =3D os.path.join(path, 'delay')
+        for test in dev_files.get(delay_path):
+                print("{}".format(test), end =3D '')
+                print((" value =3D  {}")\
+                       =20
+ .format(read_test_files(os.path.join(delay_path, test))))
+
+# display Testing state of devices
+def all_devices_test_status(dev_list):
+    for device in dev_list:
+        if (get_test_state(device) is 1):
+                print("Testing =3D ON for: {}".format(device.split("/")[5]=
))
+        else:
+                print("Testing =3D OFF for:=20
+{}".format(device.split("/")[5]))
+
+# read the vmbus device files, path must be absolute path before=20
+calling def read_test_files(path):
+        try:
+                with open(path,"r") as f:
+                        state =3D f.readline().strip()
+                        if (state =3D=3D 'N'):
+                                state =3D 0
+                        elif (state =3D=3D 'Y'):
+                                state =3D 1
+                return int(state)
+
+        except IOError as e:
+                errno, strerror =3D e.args
+                print("I/O error({0}): {1} on file {2}"
+                        .format(errno, strerror, path))
+                exit(-1)
+        except ValueError:
+                print ("Element to int conversion error in: \n{}".format(p=
ath))
+                exit(-1)
+
+# writing to vmbus device files, path must be absolute path before=20
+calling def write_test_files(path, value):
+        try:
+                with open(path,"w") as f:
+                        f.write("{}".format(value))
+        except IOError as e:
+                errno, strerror =3D e.args
+                print("I/O error({0}): {1} on file {2}"
+                        .format(errno, strerror, path))
+                exit(-1)
+
+# change testing state of device
+def change_test_state(device, quiet):
+        state_path =3D os.path.join(device, fuzz_state_location)
+        if (get_test_state(device) is 0):
+                write_test_files(state_path, 1)
+                if (not quiet):
+                            print("Testing =3D ON for device: {}"
+                                    .format(state_path.split("/")[5]))
+        else:
+                write_test_files(state_path, 0)
+                if (not quiet):
+                            print("Testing =3D OFF for device: {}"
+                                    .format(state_path.split("/")[5]))
+
+# get testing state of device
+def get_test_state(device):
+        #state =3D=3D 1 - test =3D ON
+        #state =3D=3D 0 - test =3D OFF
+        return  read_test_files(os.path.join(device,=20
+fuzz_state_location))
+
+# Enter 1 - 1000 microseconds, into a single device using the #=20
+fuzz_test_buffer_interrupt_delay and fuzz_test_message_delay # debugfs=20
+attributes def delay_test_store(device,delay_length, quiet):
+
+        try:
+                # delay[0]- buffer delay, delay[1]- message delay
+                buff_test =3D os.path.join(os.path.sep,device, 'delay',
+                                            fuzz_delay_types.get(1))
+                mess_test =3D os.path.join(os.path.sep,device, 'delay',
+                                            fuzz_delay_types.get(2))
+
+                if (delay_length[0] >=3D 0):
+                        write_test_files(buff_test, delay_length[0])
+                if (delay_length[1] >=3D 0):
+                        write_test_files(mess_test, delay_length[1])
+                if (not quiet):
+                        print("Buffer delay testing =3D {} for: {}"
+                                .format(read_test_files(buff_test),
+                                buff_test.split("/")[5]))
+                        print("Message delay testing =3D {} for: {}"
+                                .format(read_test_files(mess_test),
+                                mess_test.split("/")[5]))
+        except IOError as e:
+                errno, strerror =3D e.args
+                print("I/O error({0}): {1} on files {2}{3}"
+                        .format(errno, strerror, buff_test, mess_test))
+                exit(-1)
+
+#enabling/disabling delay testing on all devices def=20
+delay_test_all_devices(dev_list,delay,quiet):
+
+        for device in (dev_list):
+                if (get_test_state(device) is 0):
+                        change_test_state(device,quiet)
+                delay_test_store(device, delay, quiet)
+
+#disabling testing on single device
+def disable_testing_single_device(device,test_type,quiet):
+
+        #test_type represents corresponding key
+        #delay method in delay_methods dict.
+        #special type 0 , used to disable all
+        #testing on SINGLE device.
+
+        if (test_type is 1 or test_type is 0):
+                #disable list [buffer,message]
+                disable_delay =3D [0, 0]
+                if (get_test_state(device) is 1):
+                        change_test_state(device, quiet)
+                delay_test_store(device, disable_delay, quiet)
+
+#disabling testing on ALL devices
+def disable_all_testing(dev_list,quiet):
+
+        #delay disable list [buffer,message]
+        for device in dev_list:
+                disable_testing_single_device(device, 0, quiet)
+
+if __name__ =3D=3D "__main__":
+        main()
--
2.17.1

