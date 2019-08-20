Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6BA953C3
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2019 03:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfHTBwA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Aug 2019 21:52:00 -0400
Received: from mail-eopbgr820104.outbound.protection.outlook.com ([40.107.82.104]:41280
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728647AbfHTBv7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Aug 2019 21:51:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LERXu6ZeBAdw418DlfdnsOAPDb/O2TNYL52tp6bUgwDLo67Yj+VtxnTrczEfF4clH4vFKCVjfKB4IhcQ9AG9Oe3xyAJwNogiQ8TNKhv4PyuX3Tmbv42ZdVowKSH+4tFWaHnsYvr+VeiU0YgLsXhfBPJD7xUnRyDnYt15lXXQZysLovnAWSZ5HOs+AGjwQaS75CnHaoLKU+ZhlAkHdehU/Y7R7l1XPdt/MBp2e1gueooIMGUHngcbkahydryM7p4xaTO/ssvmKROA4TgHp/tKFG/KaVXZnC6uK+7Wsm4bI+fCxzBwLT3a+g7R8AEx6JTwZ3EpOycKZGGaOuCHkghwTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hJr8IWMJPTB/YsbmuTuwamrsHWCGeWw/9qMFsYFuOo=;
 b=lWYMzoQcnXL2zhfNk8H5OWdgprp5uEqthU5+V6RnnSBGyvyNkwC7DlUDePiMCZGNu3Y5VMLYu88KItuib9JUKIOPIwNrsEqfV+ONFddrU0ij7LL96BzE4fddSLWuZ6lGdJnfLsnRj/Tm/MuRW3yfOSNCtwea6QaV2f6DCX84eo9cXtg3xHq+bVreoGc+/aaDducbFfjaeW4eKgddGXQE7a/LFd44mD5lpCinT3rIXbjdW/56pU64X8nHHIfxaEP9YQh8gYSME3Qzq1YazOXGmsWMp/wSyKKtQut0jRT644tDn7szUdoROwYBstFebzYuUveT2pT6+vfKzJnNIU8/Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hJr8IWMJPTB/YsbmuTuwamrsHWCGeWw/9qMFsYFuOo=;
 b=CWkIH3+iemjeNrwuqpq5M5ts6kQeYmDHwGPTbqesV+e1CpoObMyPITTGWTAmPyDa4cWXZ9g0kHyO9A4+u6ymjCfFF0raH92ZeBQQiy2HJ0RQt007g+8u6O5ODw6Mk1iAhuulbsp8jOnQVy6zCy/rQijU2dRmM6WzzicMHgB2OKU=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1133.namprd21.prod.outlook.com (52.132.114.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.8; Tue, 20 Aug 2019 01:51:57 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5%8]) with mapi id 15.20.2199.004; Tue, 20 Aug 2019
 01:51:57 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v3 00/12] Enhance the hv_vmbus driver to support hibernation
Thread-Topic: [PATCH v3 00/12] Enhance the hv_vmbus driver to support
 hibernation
Thread-Index: AQHVVvnZIajgjelkVESeQ2ijXSF4+g==
Date:   Tue, 20 Aug 2019 01:51:56 +0000
Message-ID: <1566265863-21252-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0056.namprd21.prod.outlook.com
 (2603:10b6:300:db::18) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ad47d7a-0fd3-4cbe-8409-08d72510fb89
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1133;
x-ms-traffictypediagnostic: SN6PR2101MB1133:|SN6PR2101MB1133:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <SN6PR2101MB11336DC67427D6C4126ED4AFBFAB0@SN6PR2101MB1133.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(53754006)(54534003)(189003)(199004)(64756008)(6436002)(3450700001)(1511001)(50226002)(14444005)(81166006)(256004)(6486002)(2501003)(36756003)(66556008)(66476007)(4720700003)(8676002)(8936002)(66066001)(25786009)(66946007)(22452003)(26005)(10290500003)(53936002)(99286004)(478600001)(43066004)(386003)(2906002)(6506007)(3846002)(6116002)(102836004)(186003)(54906003)(966005)(476003)(486006)(10090500001)(81156014)(5660300002)(316002)(110136005)(2616005)(107886003)(6512007)(6306002)(7736002)(14454004)(52116002)(305945005)(86362001)(4326008)(66446008)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1133;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FiQjPP8hdkw7foiMt86vap4AkN0qY/h/9XBFr1JVUXUbLdn0VQ272rhyvd4JkMfnn8EsFJnd84T/GAf9vG9SIPYPDDY1dkeLCEp7LdjdVgAGpGVn652sguv3GyiG3iI+Nag2IHAp7HB43F16RKjgg/FDioPiCPWH7ZCtDOM1MWNgFbLsAGyHrUGtiJrT/u429spislBZTGtEDNvhDQ6ivnqiNhR72cQMds66cvIREZpaG/x3qPdL3N8lbP+/Y4wbqO08mNQTx2UTxTDCV5RqNoSMYAhCSBt4Z/LOR1dSWth92NXDvtxtK1Tz1PTCC5Dr9KPIKYPr3kSZg2XScj+fzyWFW7M/bx+GL363FkpuaekgDqbLflbLnFHoXRyRaQvgDKdl0GqaHToiUHzAU4EcaxtMX8GnJfR0CUJ83H1NZ8I=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad47d7a-0fd3-4cbe-8409-08d72510fb89
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 01:51:57.1522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cWA4cKOG3tQCUmqOOvWD1Fdfr9crbaLjhfCfoDCnIV/XFs3dzRQFd+CsBdHTgut6BvW1W7Q16R9t6VdLhHFLYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1133
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi all,
The patchset is to enhance hv_vmbus to support hibernation when Linux VM
runs on Hyper-V. A second patchset to enhance the high-level VSC drivers
(hv_netvsc, hv_storvsc, etc.) for hibernation will be posted after this
patchset is acceped. If you want to test this hibernation feaure, all the
needed patches can be found on my github branch:
https://github.com/dcui/linux/commits/decui/hibernation/2019-0818/v5.3-rc5

This patchset is based on v5.3-rc5. =20

Please review.

Hi tglx,
I hope all the 12 patchset, including the below 3 patches,

[PATCH v3 01/12] x86/hyper-v: Suspend/resume the hypercall page for hiberna=
tion
[PATCH v3 02/12] x86/hyper-v: Implement hv_is_hibernation_supported()
[PATCH v3 03/12] clocksource/drivers: Suspend/resume Hyper-V

can go through Sasha's hyperv/linux.git tree, since all the changes belong
to the hv stuff. However, if you think it's better for these 3 patches to g=
o
through the tip.git tree, it also works for me.

Hi Michael Kelley,
I added your Reviewed-by's for patch 1, 3, 4, 5, 7 and 9, since you reviewe=
d
these patches. Please review the others.

Looking forward to your comments!

Thanks,
Dexuan

Changes in v2:
  Patch 3: Improved the changelog and added a comment.

  Patch 4: Remove the "hv_stimer_cleanup" in hv_synic_suspend(), because I
           suppose https://lkml.org/lkml/2019/7/27/5 will be accepted. Also
           improved changelog and the comment.

  Patch 5: Fixed the third argument of print_hex_dump_debug(). Also improve=
d
           the changelog.

  Patch 6: Improved the changelog and the comment. Added a check for the
           'vmbus_proto_version' in vmbus_bus_resume().

Changes in v3:
  Patch 2: Add a new API hv_is_hibernation_supported().

  Patch 6: Add a new helper function is_sub_channel().

  Patch 8: Find the old channels via Instance GUID rather than the RELID.

  Patch 10: Add code to clean up  hv_sock channels by force

  Patch 11: Add code to wait in the suspend path: all the hv_sock channels
            and sub-channels should be cleaned up first before Linux sends
            the VMBUS UNLOAD message.

  Patch 12: Add code to fix up the old primary channels before further
            resuming.

Dexuan Cui (12):
  x86/hyper-v: Suspend/resume the hypercall page for hibernation
  x86/hyper-v: Implement hv_is_hibernation_supported()
  clocksource/drivers: Suspend/resume Hyper-V clocksource for
    hibernation
  Drivers: hv: vmbus: Break out synic enable and disable operations
  Drivers: hv: vmbus: Suspend/resume the synic for hibernation
  Drivers: hv: vmbus: Add a helper function is_sub_channel()
  Drivers: hv: vmbus: Implement suspend/resume for VSC drivers for
    hibernation
  Drivers: hv: vmbus: Ignore the offers when resuming from hibernation
  Drivers: hv: vmbus: Suspend/resume the vmbus itself for hibernation
  Drivers: hv: vmbus: Clean up hv_sock channels by force upon suspend
  Drivers: hv: vmbus: Suspend after cleaning up hv_sock and sub channels
  Drivers: hv: vmbus: Resume after fixing up old primary channels

 arch/x86/hyperv/hv_init.c          |  41 ++++++
 drivers/clocksource/hyperv_timer.c |  25 ++++
 drivers/hv/channel_mgmt.c          | 127 +++++++++++++++---
 drivers/hv/connection.c            |  35 ++++-
 drivers/hv/hv.c                    |  66 ++++++----
 drivers/hv/hyperv_vmbus.h          |  33 +++++
 drivers/hv/vmbus_drv.c             | 262 +++++++++++++++++++++++++++++++++=
++++
 include/asm-generic/mshyperv.h     |   2 +
 include/linux/hyperv.h             |  16 ++-
 9 files changed, 558 insertions(+), 49 deletions(-)

--=20
1.8.3.1

