Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCB6AAED6
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Sep 2019 01:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388938AbfIEXBQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Sep 2019 19:01:16 -0400
Received: from mail-eopbgr700134.outbound.protection.outlook.com ([40.107.70.134]:14272
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726635AbfIEXBQ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Sep 2019 19:01:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SU2A7RWlDrUgJvoS2Q4UzNKx69Bna3goMj1TL3o+fzT4DiXO5H07Mn67AZjYTCSsrPSWa6Y+oJv3FJdBgYFhHzc97cwbEGLS+0cQroprqzm0JL3T/DnhCEJ5pbgBovpuPa/Akkp+BPwUAJGmvPFGhG0JElbI/K5SlJrbpZfI49xa/ZPYmUM+zT15jHDfzC1ARuF4D7gxY136F6rS63sWgj0raiSK93773TVNjz9iNzWf1X57OOj8LAsNkipDiehKoY51CH5FYNoaqNVDvulHrEUDNttJMfzil/+GIrqueXjOBo5hGUWI2q4wc5qS32yWnM7KlXrrmGFRx2QI18JdbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abOO3pBPLe7bUTueO3RQdKVsAoF2EJyg6Mzyrc2pj1A=;
 b=jRqlSeGQ5CX8ZUx1BIm5pUcR8WhaQy2KeJU/NPghjRld56rlHddb6NqC/86S7WMh81iBjhjEmp/IhttOgdI6ZmKQRBR6pZr3e86JCMiD/cyO3+DwzEkyuFY6PjG3h6+bedhK/jhk//0iBOMnDKTrNeOkW/l4sQ/VS7IoBJY1ep8JlEzGYaw6DqCbxvplDuogQMmL1OhmBDwkhsiITbCMqENFSzLgTLIITuLUjb0wsNpjIQLp5ZJxYqxXBEBIUEh/uMET7/wp4ezSdRm9YatVQ+d4ps6xNNMG34wg+Rt/PdWTKphBrY7Uq45l+aP53I2uzj45gg77mBHnCGJ6BukRTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abOO3pBPLe7bUTueO3RQdKVsAoF2EJyg6Mzyrc2pj1A=;
 b=lgMhF+dD0ZVNspvqRZ4SOKXDeHF9U3aFjpBbg/87lGSuhJKCs7yEv8XVhktHercey120DNdKq0njU8zAGdlghw1Cek5X0mbWNxchB+7i/IrrEnmiwkGtHrhwy1ZYIGBkGpj6FegcCnI+vBb9diZ9yuxFe0fotXeTHhkg+rSumbQ=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1038.namprd21.prod.outlook.com (52.132.115.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.4; Thu, 5 Sep 2019 23:01:14 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Thu, 5 Sep 2019
 23:01:14 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v5 0/9] Enhance the hv_vmbus driver to support hibernation
Thread-Topic: [PATCH v5 0/9] Enhance the hv_vmbus driver to support
 hibernation
Thread-Index: AQHVZD3RG3904IwHxkahsxc3tv1IQA==
Date:   Thu, 5 Sep 2019 23:01:14 +0000
Message-ID: <1567724446-30990-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0048.namprd02.prod.outlook.com
 (2603:10b6:301:73::25) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf10697d-36c0-441b-585a-08d73254f390
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1038;
x-ms-traffictypediagnostic: SN6PR2101MB1038:|SN6PR2101MB1038:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <SN6PR2101MB1038A80C8ECE2B3B497A07B3BFBB0@SN6PR2101MB1038.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(189003)(199004)(6506007)(66446008)(256004)(14444005)(10290500003)(478600001)(476003)(102836004)(186003)(36756003)(52116002)(64756008)(6306002)(71200400001)(26005)(3450700001)(6512007)(71190400001)(305945005)(107886003)(4326008)(66946007)(316002)(966005)(7736002)(6436002)(66556008)(386003)(22452003)(66476007)(6486002)(486006)(53936002)(2616005)(25786009)(14454004)(54906003)(110136005)(5660300002)(2501003)(3846002)(2906002)(6116002)(81156014)(8676002)(81166006)(86362001)(50226002)(4720700003)(66066001)(10090500001)(1511001)(99286004)(8936002)(43066004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1038;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cJxSKbnLM1JphbphYTiQozh1tj+tIqZfbhtxTfQAsIVd4hJqTLCg8s2r9Em4OjGQB4YhZrq59KXx7F4RsTGRipSrFB8+t1heY3J76jB0ZNC3C/32g9ZZGyj3Q/2HK22yjmMkDK+XirB8lPJlPFhzMBHrQcLY+35TzNP4dN2o+QpEXCQqeOcLBvzCLHDl3EAVrblHOZuM5m1Q+EAEqfqk8P6Cv/9+VmG3Le8jb76R5MDMvuZQN4P8XZnPbQoI/FWq20q++vupuH8v4dR+acHPtzsPCx4rhWL3xQqKP4HzCFu00jwJIB9OVp21UD25cgwLh1uRAVbXqL3Jp966khfwMC+bkQ3UbQnMP4zNbWXxY3//K2CWG5WynqE2Gfj2ZhqkMAdYjtaSqVXmqVIN9Ux/sn9Y60VmhbFTeZCcXcw3o9c=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf10697d-36c0-441b-585a-08d73254f390
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 23:01:14.3148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B8EM54+HApO/G4iJvb2p1XNvgh4fG5quskR38pmBMyb6VrWDsaF9+OIkwuh8lgdXOtSjtYuidpEWxBMydYQimg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1038
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patchset (consisting of 9 patches) was part of the v4 patchset (consis=
ting
of 12 patches):
    https://lkml.org/lkml/2019/9/2/894

The other 3 patches in v4 are posted in another patchset, which will go
through the tip.git tree.

All the 9 patches here are now rebased to the hyperv tree's hyperv-next bra=
nch:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=3Dh=
yperv-next
, and all the 9 patches have Michael Kelley's Signed-off-by's.

Please review.

Thanks!
Dexuan

Dexuan Cui (9):
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

 drivers/hv/channel_mgmt.c | 161 +++++++++++++++++++++++++---
 drivers/hv/connection.c   |   8 +-
 drivers/hv/hv.c           |  66 +++++++-----
 drivers/hv/hyperv_vmbus.h |  30 ++++++
 drivers/hv/vmbus_drv.c    | 265 ++++++++++++++++++++++++++++++++++++++++++=
++++
 include/linux/hyperv.h    |  16 ++-
 6 files changed, 497 insertions(+), 49 deletions(-)

--=20
1.8.3.1

