Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4CE7CAEA
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jul 2019 19:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfGaRwE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 31 Jul 2019 13:52:04 -0400
Received: from mail-eopbgr710125.outbound.protection.outlook.com ([40.107.71.125]:44032
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726514AbfGaRwE (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 31 Jul 2019 13:52:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzJ1COP8hoD14wPGdsKxSKnnevgt081MCGhDs4y5un3OLCHAGm38PXJwDV7DTn91eXkIDSBF9uXacH68XOgoK7AsMFJuL9jPZEPXNagDqNmIJvUFSSOWhwwrPfHGUC392pOpAyXawyoSEk6xqfjWqSh21gR2rOAV1tPHOk42gajyWBKcpVOCRCO+hqEKtbF+NjnbMI+5HatHgmMUABELcALqVXFr3o4Xlz4QqUqDzDoq6tJ06m1Ys+Fer0LueszJzBaLaym3jzWAGMqPOYdsFsQpWjMcp+oXXbLfvaKn1/lbHHKLZ4CcaIPkR8V3NABYc6Of2zY43bFbTi39fis/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=583sQVIyyN2tLAH+TAGFp5lPFandz/cZm/GnpU7H0EM=;
 b=WbBLhfAZaz1anb8Uz6GmV6Cm4L3BbY49lBi+/2YsVnWCLweXt+bSTgwtQgjxjVbnGDbZPFx0Bje5o3Rrf1GgR+7nUOMjUDQo5n2cZ0YtbIot4hVWcIY+Qh+rl/+MJHir/OIz+ZRgVbNRm4cFsK+AZOIyOhkKCcNFvy5wDOtez+f/A3GKmSyG1pzZR3wuvCfDZiboD++hcQ8CA9UwvgVQBo5Re6Xo/1KCp2la4j3L9O3RbkGLcKgqx/+6tFBsekWIEA5zVlbhR57xeDUSWOzsZapBsNcAq1NN37U3RC2AIYCWPs+X5iznaaHfN4R5Y2k3evOjRrfijabzZSm+ozmgKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=583sQVIyyN2tLAH+TAGFp5lPFandz/cZm/GnpU7H0EM=;
 b=MPtIO4g4dCeV+/iN8dBSm9vP7w4Zo6y5vrU9CF2yI16QarRpClbmqc+CQ9zdzMRi6wzXiOXmrpeGYFIS5wH32Yjq0NFKdHr9Pja5wpjs5xQMOu3l8oVJTKrYtawsUglk6tCE9L3wivQRPkSk4fDluq4kOsbZ1ORZaO4vgedTpBU=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1120.namprd21.prod.outlook.com (52.132.117.161) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Wed, 31 Jul 2019 17:52:01 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::d0c3:ba8d:dfe7:12f9]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::d0c3:ba8d:dfe7:12f9%7]) with mapi id 15.20.2157.001; Wed, 31 Jul 2019
 17:52:01 +0000
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
Subject: [PATCH v2 0/7] Enhance the hv_vmbus driver to support hibernation
Thread-Topic: [PATCH v2 0/7] Enhance the hv_vmbus driver to support
 hibernation
Thread-Index: AQHVR8iniM4gYr/V/EWj4FLeICRtrw==
Date:   Wed, 31 Jul 2019 17:52:00 +0000
Message-ID: <1564595464-56520-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1301CA0011.namprd13.prod.outlook.com
 (2603:10b6:301:29::24) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c4aceb8-5866-4309-15cc-08d715dfc9fd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1120;
x-ms-traffictypediagnostic: SN6PR2101MB1120:|SN6PR2101MB1120:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <SN6PR2101MB11205342D0476256957F5E61BFDF0@SN6PR2101MB1120.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(54534003)(199004)(189003)(68736007)(10090500001)(36756003)(53936002)(6512007)(54906003)(3846002)(305945005)(52116002)(4720700003)(6306002)(8676002)(3450700001)(14454004)(966005)(6436002)(6486002)(99286004)(8936002)(107886003)(25786009)(81156014)(71200400001)(81166006)(71190400001)(6116002)(66946007)(10290500003)(22452003)(486006)(7736002)(86362001)(476003)(1511001)(50226002)(316002)(102836004)(478600001)(66446008)(66556008)(66476007)(64756008)(256004)(4326008)(14444005)(2616005)(186003)(110136005)(66066001)(6506007)(43066004)(26005)(386003)(2501003)(5660300002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1120;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0xj/SQH2mFkI+82CfJdM4Yv9TlnGFB4KHxVonrf6i8Wv8gobuC3Qh63PGCRLrruj8991AsCQQ5VNiwanIlcmlEQrwrz4rWNEF48OrFpvVOXES8/niGl+bj8Dw3KYL+woaqhJDRKH9WW0Z3vuXwlaR1PESkwh+0Ie5a////e1arsRnQ4kcATaUdLspXN+TeZ6DrvYGqip8RaqPeNcveUdDNbOmnZYWlR/EZX/PAnKgQkmO7lpVDtStNBYX2PVROGzHO27gMjrsudf9eDalfVkpTISYJj1JlosKAENrkFi6vgEOCxqnv41ERSxL6TDjOBSbiS3quZSuFbEkrnSiPLPjoCqPsSVXcP7Bf0n78RAbDnrnhvELqPV7jAAcaI4w3RkPCS5V+bMFYSWmNfma43XziSRDKq50t2VDEN6PmjMZVc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4aceb8-5866-4309-15cc-08d715dfc9fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 17:52:00.9719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZP3xkhek/Z7qYVeLNcGuMZvTlaIeRJpDRJRbr8GhyehPf2hfJyNUTDJTsu+jN7nAuV+uxf/TW9teLG2XZ6ptnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1120
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi,
This is the first patchset to enable hibernation when Linux runs on Hyper-V=
.

A second patchset to enhance the high-level VSC drivers (hv_netvsc,
hv_storvsc, etc.) for hibernation will be posted later. The second patchset
depends on this first patchset, so I hope this pathset can be accepted soon=
.

The changes in this patchset are mostly straightforward new code that only
runs when the VM enters hibernation, so IMHO it's pretty safe to have this
patchset, because the hibernation feature never worked for Linux VM running
on Hyper-V.

The patchset is rebased on the branch hyperv-next of
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
and can also cleanly apply to Linus's tree.

Hi Greg, tglx,
I hope the patchset can go through Sasha's hyperv/linux.git tree, because
the changes belong to the hv code and they need to be together to work
properly.

Michael Kelley reviewed the v1 of the patchset, so I added his Reviewed-by
for patch 1, 2, 3 and 7. Michael, please review the other 3 patches again,
and give your Reviewed-by if the updated version is ok to you.

Changes in v2:
  Patch 3: Improved the changelog and added a comment.

  Patch 4: Remove the "hv_stimer_cleanup" in hv_synic_suspend(), because I=
=20
           suppose https://lkml.org/lkml/2019/7/27/5 will be accepted. Also
           improved changelog and the comment.

  Patch 5: Fixed the third argument of print_hex_dump_debug(). Also improve=
d
           the changelog.

  Patch 6: Improved the changelog and the comment. Added a check for the
           'vmbus_proto_version' in vmbus_bus_resume().

Thanks,
Dexuan

Dexuan Cui (7):
  x86/hyper-v: Suspend/resume the hypercall page for hibernation
  clocksource/drivers: Suspend/resume Hyper-V clocksource for
    hibernation
  Drivers: hv: vmbus: Break out synic enable and disable operations
  Drivers: hv: vmbus: Suspend/resume the synic for hibernation
  Drivers: hv: vmbus: Ignore the offers when resuming from hibernation
  Drivers: hv: vmbus: Suspend/resume the vmbus itself for hibernation
  Drivers: hv: vmbus: Implement suspend/resume for VSC drivers for
    hibernation

 arch/x86/hyperv/hv_init.c          |  34 +++++++++
 drivers/clocksource/hyperv_timer.c |  25 +++++++
 drivers/hv/channel_mgmt.c          |  29 +++++++-
 drivers/hv/connection.c            |   3 +-
 drivers/hv/hv.c                    |  66 ++++++++++--------
 drivers/hv/hyperv_vmbus.h          |   4 ++
 drivers/hv/vmbus_drv.c             | 138 +++++++++++++++++++++++++++++++++=
++++
 include/linux/hyperv.h             |   3 +
 8 files changed, 270 insertions(+), 32 deletions(-)

--=20
1.8.3.1

