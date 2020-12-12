Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014382D83D0
	for <lists+linux-hyperv@lfdr.de>; Sat, 12 Dec 2020 02:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406303AbgLLBVp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Dec 2020 20:21:45 -0500
Received: from mail-co1nam11on2113.outbound.protection.outlook.com ([40.107.220.113]:23392
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405263AbgLLBVS (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Dec 2020 20:21:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZSEyCggheYnmSMglFaougJVKsjs4AhHmUe7vbkWHo5rJHF9SRTen5Fs9P2+Uhua6C+rkuhW6Tp5sWcX3wYrnMYNEGFc+Lafg2Ue8blR/9d2mOgRTmg2TTY6vldFKlM2jTLd20TMiBRzck/VT7BD7zsKSLvuep3wL66p4xYmTmtKWUT7x0TlP3+U8/qA2BtJhp6hY1XXpYVThOSJcCDdvNcirGDNEeM/vFmu+nh6TfOMGOnkfQgYqex5FMBMNElXQYV21qebTDdXRrkIPUgDuh8tUZZJ4PwiEhLWQk8QOxs4ffMh/jahCxE4mXXKkDTbj2idVC6dq+5WZiTeEQwhUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fqnKBCG7QBwhdU79CJLMXQqKjTazJFW1AVCZzVk0uw=;
 b=Zd4vEhgKdC9nPzGgiJs6Vaoji1hqDPNHZUV8Bz549yvva/wloHfP4nfrpZwPF/XLdl5Lo44OY2oMos/Nqhz09t8ZPSf05CZ5vGiab6bBgUD0O+ebRvAUEwuCh3IMmdzvxO1xwn7oD3mv/WiYQsy0vcBBoMcXz0+VvvrTLYZVkYhcS/AzSBJhVVwlrNl5oLyoXpxCVmZcIfZRXjDmpLvr2asW4DCiJShoHqEeWlP3h0pwqmUCjOSyghSQOHXWMF2JDgomCupi4ViymUHXTwNvg874wfcOpYY31CH9JrccxZ5FrepPV1VVoCJEihZfVF+TL6KLeKxlF8bFCuazKxAw8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fqnKBCG7QBwhdU79CJLMXQqKjTazJFW1AVCZzVk0uw=;
 b=VXVNyAf4knmeOCS75yuTez7Gve/IDMJSdVcngvDItwe0iKOs7AAYvBnU6j5R7HalQwq6tspI0ouIdXA4NW196ru8sIqKvQSz2aEuzpL6VvavnbGyecsGjq0b2yWYY3KtFkyBcVVyCpiXNQZkOSY6QcmdnSgQ+yB+N6QB//Z9wmA=
Received: from (2603:10b6:300:77::17) by
 MWHPR2101MB0874.namprd21.prod.outlook.com (2603:10b6:301:7e::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.2; Sat, 12 Dec
 2020 01:20:30 +0000
Received: from MWHPR21MB0863.namprd21.prod.outlook.com
 ([fe80::9de4:6549:6890:b7ba]) by MWHPR21MB0863.namprd21.prod.outlook.com
 ([fe80::9de4:6549:6890:b7ba%5]) with mapi id 15.20.3654.018; Sat, 12 Dec 2020
 01:20:30 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: How can a userspace program tell if the system supports the ACPI S4
 state (Suspend-to-Disk)?
Thread-Topic: How can a userspace program tell if the system supports the ACPI
 S4 state (Suspend-to-Disk)?
Thread-Index: AdbQHxbRjXJd8DrBQaCk5mureoGP6g==
Date:   Sat, 12 Dec 2020 01:20:30 +0000
Message-ID: <MWHPR21MB0863BA3D689DDEC3CA6BC262BFC91@MWHPR21MB0863.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cc632347-9b72-4af3-830a-ef8dbaa58bab;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-12T00:35:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:8009:837e:3c90:8d73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fc2c7293-c8e0-4c85-1a74-08d89e3c1da0
x-ms-traffictypediagnostic: MWHPR2101MB0874:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR2101MB0874EE378D0CF2BBC4380500BFC91@MWHPR2101MB0874.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:586;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mx90NuUZT8mKv0TFSVcxx0n2/BGn8z2dgeBl7/6tCO0VGny+oHNFFFAKSjpupUJD7UK5M+3BCT3KlvRHxH/PQmypZ/bf7bkqdTibtaUn+n8UGIZcpr6PPHlRs+s7tRhEBBbE5WX/9GBoEgrHTtvyAnyhKJ+6Z4sQKYwva3zxToAv0whWFctljSDgNn8MPMWfrVhvtE5ZnBkLDMVj76MHXZbRuWJWHMSJlS7fjQQrAZPuYqgRywuTYBSf8RoK5kfQcEFvKkZ347m6l0wWI4oP0MXwZV0MTmKUnX9aWDXQcqchyzjuKCs/IPPWgbMmJ+MvjRrLYX7gUPIh7iOQP+nqhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB0863.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(136003)(9686003)(66476007)(2906002)(66556008)(64756008)(66946007)(54906003)(52536014)(6916009)(76116006)(66446008)(55016002)(5660300002)(33656002)(7696005)(4326008)(86362001)(107886003)(82950400001)(71200400001)(450100002)(6506007)(8676002)(508600001)(82960400001)(8990500004)(186003)(10290500003)(83380400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PJZf52bVATwbktDyLGMkDGhJRnQYw2+JptWlZm/N5SUheqHZSXzAmSq/iHUl?=
 =?us-ascii?Q?ddc/+g/aqljJ+zA6eISclf+OS6bclvz/VwxKoNYYedW2XvmhcZ5Lv0GuYJGb?=
 =?us-ascii?Q?YTTHczmifZKZCtaO5VdbbAwnN/hdG8aUOenJbsY55jbiF/I00NAU+XvhXDGi?=
 =?us-ascii?Q?xyxPTAO1dJmtQNl6C8Ij57JOS6F3YFhGYmZIp9rX31fJo0pa38jJEQebGWjg?=
 =?us-ascii?Q?meRD+iGmPIbH65Tpp6y+ZsmnEJu6BvR6p41qbvA+N5Riqealm5iD/2CQiotk?=
 =?us-ascii?Q?ti2mlUSnhxrksD38KsC5F/geBB82hp51ZX5GdM7eqyFwmQDZPYF5nVOIBys0?=
 =?us-ascii?Q?OjTiRzOzBcXRwmQjCMBP0W9vvUPvqEx4cZmeQMclbD2zR66+nvSTqzGNyofx?=
 =?us-ascii?Q?Eicqda1ysVyXGQJl8nHO2kbCH8XqPwFWRaAerdA9mIsdj8qHKiSVYfiEF69t?=
 =?us-ascii?Q?5on7CMjWh71GbBwD2xZCyn50ufievwFlDwzq6KaVDYc2WTspLpYGgZXljhpG?=
 =?us-ascii?Q?jPLODZ26nkaAGF4Ipjvw1iDYvUB7VbO0S6LZo/eadTgJ7JwfpC874MOCae/s?=
 =?us-ascii?Q?jMNQM2u+78COfQzQ2i0D98OAEMpA60q5Nu6jHngiUGhVyO+aW+N3BqjnjDtO?=
 =?us-ascii?Q?VxUnF9P1Z4cpdDKJddz0ZY4ank3ILVQTw2cJymZScXc+6wTjZl17N20ZvKIb?=
 =?us-ascii?Q?uRB3dWP2C4CZMBLKmmLNz3QYHjVDCKnwr71psBcsLzb1SBF8kLw4KI4gYYuC?=
 =?us-ascii?Q?2HQXQvI6pypdJycUr62vZiebZVmYE41uCimUn8yBIiQzyxy8YBH9bAi9JfnS?=
 =?us-ascii?Q?5zLZWx4+h71Ts8ZC4FrB2o4ww5kRkQxzxgK5HFQjiTMpz8vYi3F41B2dTNDa?=
 =?us-ascii?Q?+hz+BMrRR427Krl/LQCpofkUEX6QffXAAoVKt9wPJhOgqQuNAZfZdilERjQA?=
 =?us-ascii?Q?Zct+5kXOHOxD8HAYKwcAHgP91+I8OxT44WcREfYzl7zx7OsokRRsMIiHKIRp?=
 =?us-ascii?Q?ZLgcyoyFFWyn/zTe9zTTq8GKQs6b2r68dQtFEr/+meyRLCQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB0863.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2c7293-c8e0-4c85-1a74-08d89e3c1da0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2020 01:20:30.3594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uZu9n0M2QEHO4CTAZzO6IWdHoiAzQtUL3hjpCloCMszs9XyM8qIg378ha8IOCOLeWuELXrjSjVPE1xxVfh5oSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0874
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi all,
It looks like Linux can hibernate even if the system does not support the A=
CPI
S4 state, as long as the system can shut down, so "cat /sys/power/state"
always contains "disk", unless we specify the kernel parameter "nohibernate=
"
or we use LOCKDOWN_HIBERNATION.

In some scenarios IMO it can still be useful if the userspace is able to de=
tect
if the ACPI S4 state is supported or not, e.g. when a Linux guest runs on=20
Hyper-V, Hyper-V uses the virtual ACPI S4 state as an indicator of the prop=
er
support of the tool stack on the host, i.e. the guest is discouraged from=20
trying hibernation if the state is not supported.

I know we can check the S4 state by 'dmesg':

# dmesg |grep ACPI: | grep support
[    3.034134] ACPI: (supports S0 S4 S5)

But this method is unreliable because the kernel msg buffer can be filled
and overwritten. Is there any better method? If not, do you think if the
below patch is appropriate? Thanks!

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 0aefd6f57e0a..931a1526ea69 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -9,6 +9,7 @@
 #include <linux/export.h>
 #include <linux/kobject.h>
 #include <linux/string.h>
+#include <linux/acpi.h>
 #include <linux/pm-trace.h>
 #include <linux/workqueue.h>
 #include <linux/debugfs.h>
@@ -600,8 +601,12 @@ static ssize_t state_show(struct kobject *kobj, struct=
 kobj_attribute *attr,
                        s +=3D sprintf(s,"%s ", pm_states[i]);

 #endif
-       if (hibernation_available())
-               s +=3D sprintf(s, "disk ");
+       if (hibernation_available()) {
+               if (acpi_sleep_state_supported(ACPI_STATE_S4))
+                       s +=3D sprintf(s, "disk+ ");
+               else
+                       s +=3D sprintf(s, "disk ");
+       }
        if (s !=3D buf)
                /* convert the last space to a newline */
                *(s-1) =3D '\n';

Thanks,
-- Dexuan


