Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4174BA5E7A
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Sep 2019 02:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfICAXV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Sep 2019 20:23:21 -0400
Received: from mail-eopbgr730136.outbound.protection.outlook.com ([40.107.73.136]:5728
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726833AbfICAXU (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Sep 2019 20:23:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqZ52aSMuUHcg/2/jWQwgjRGQ5vMsdDDMVxouIR0hP6R/bpZ9z0D+TSekpsvt9kkXK0OqJotVjaT4oa2lxRhOjcoaeoDIVSkGcO8nll3iE6F/AQ/o0E+qRBgG6gDONz1ulPzhxzC4gl7CywTyVU8w/7iisNm9MNwbpAIFoNn/qhjsoe+vSzFq/pE0n1bMPIEqs930EpzcLuSjPmJypEy8P3wQ31iaBxzf9WnpMK4NrdKmwZCK4PECgnDmtpE7NRu9GViUQFv0XJl3pf+PjrPsL7qKnOftETnBKG0bSmfjHxkiGYGI5PBRzQS4b6fF/wxk5MqVfpO15IxNRPdcTar2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnCfg1N4wuNHrUd0iqxXKXq7ThgvPnocuUbvTy5bYKo=;
 b=miOJfpd8JthRwCdTT3mifide+Y4zDNtn7wE1TNpXKEh+4nIU+zlegtBgVvJwxDvBLth1TeLl6WFLh+KWemgQjcmeR5v8lfGQW8j/L1+2hmkLiuFhYb9ZUH1Oyp1cUGlVIN8VZAvKLzp5sN6OBXpRv7fd15ltGHvP5LqPGoQq6Duu+RLRulE/osHAFmOKZbFpa6EbjNEBliGgtBXRbw80y23o88noJQOsLGa+RGdLwUun9t+x2M4xd9WQKBvZAG78hOmqQbPbRfjceRUIKtN314XvHa2xf6f3rQByA9TJcsSXtSngn99521cw1h979AzAQvwXH24Vu58juAxE7Bs4zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnCfg1N4wuNHrUd0iqxXKXq7ThgvPnocuUbvTy5bYKo=;
 b=b0ez5g9LbOw1qSOs040+hPKnBcp7yRDs3PpoG4JZQC8GnLqodq3xLE9hp6camYHtci6Iw/JqORZy6QkCf+BV5zq7CDmiMvKVGdLv2ia6C9r4ogb1NbiNkNUqHz8KgJVF3pHqOAt32cm5iWT3d4Vx3YBWeOR0pGMK+LP629rAFw4=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1054.namprd21.prod.outlook.com (52.132.115.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.2; Tue, 3 Sep 2019 00:23:16 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Tue, 3 Sep 2019
 00:23:16 +0000
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
Subject: [PATCH v4 00/12] Enhance the hv_vmbus driver to support hibernation
Thread-Topic: [PATCH v4 00/12] Enhance the hv_vmbus driver to support
 hibernation
Thread-Index: AQHVYe3H+RV2UUFd9UeiO89p3wR1Jw==
Date:   Tue, 3 Sep 2019 00:23:15 +0000
Message-ID: <1567470139-119355-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:301:1::15) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 762dd342-4e6f-438f-74df-08d73004e97b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1054;
x-ms-traffictypediagnostic: SN6PR2101MB1054:|SN6PR2101MB1054:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <SN6PR2101MB10540B594864F6A9F06F149EBFB90@SN6PR2101MB1054.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(199004)(53754006)(189003)(54534003)(6512007)(66476007)(66556008)(478600001)(10290500003)(8936002)(3450700001)(52116002)(81166006)(81156014)(7736002)(305945005)(14454004)(25786009)(966005)(8676002)(50226002)(53936002)(107886003)(2906002)(71200400001)(3846002)(1511001)(2616005)(476003)(71190400001)(6116002)(486006)(2501003)(66066001)(86362001)(36756003)(22452003)(110136005)(64756008)(386003)(6306002)(6506007)(316002)(186003)(54906003)(10090500001)(4720700003)(102836004)(6436002)(6486002)(43066004)(4326008)(5660300002)(99286004)(256004)(14444005)(66446008)(66946007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1054;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bmKmNuwjrV3pRdLLn6nvxOI+S2gkXCPnsVJOm94VtE4o3JFbzZnZoUVW/rQ3RGlefZV5XfH+dbNgSzM/kWpj4sfKKNz2pUcpJk15qxusj60DZEZw8xguUu7tJQbhTozpM9TZHTSTyRbK0t+GnY0QGDpYfUezIc30ug8mP504hMTM0TAJWZmhIbAwKBFZIT0C8QyyQwJb+xJybUFRAtvhT8qzIybmGbCZPVeJkq1rXmQGgrthSL6H56VVhWpI/yurIJS/P8ksVX2s9kII5UVscAWf93Fz/AUQgv6SBhBauCzt6VSeknT6bgAXPkDU536u1wSVf27s7fOqAAAf5eMyvgHYlrbauPWmgd3KcXmKJUUGqM+3k9KjZrgK+5HkCeRUK6t/oggbSz90G6n6JZ2/Cl0/77iVLt7FnURhBMJV740=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 762dd342-4e6f-438f-74df-08d73004e97b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 00:23:15.7335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dzmQT5tK3BM+MlDMkP2G6/jt3nDEkwFaQGJ52fOO8CsMiovNKXdCD+C8ALPn8lQEhNtLzoyAsLRC9mnfVoVGHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1054
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
https://github.com/dcui/linux/commits/decui/hibernation/2019-0830/v4/v5.3-r=
c6-plus

This patchset is based on v5.3-rc6, and can also cleanly apply to -rc7.

Please review.

Hi tglx,
I hope all the 12 patchset, including the below 3 patches,

[PATCH v4 01/12] x86/hyper-v: Suspend/resume the hypercall page for hiberna=
tion
[PATCH v4 02/12] x86/hyper-v: Implement hv_is_hibernation_supported()
[PATCH v4 03/12] clocksource/drivers: Suspend/resume Hyper-V

can go through Sasha's hyperv/linux.git tree, since all the changes belong
to the hv stuff. However, if you think it's better for these 3 patches to g=
o
through your tip.git tree, it also works for me.

Hi Michael,
I added your Reviewed-by's for patch 1, 3~7, 9~10, since you have reviewed
these patches. Please review the v4 of the others: 2, 8, 11 and 12.

Thanks,
Dexuan

Changes in v4:
  Patch 2: Enhanced the changelog.

  Patch 8: Moved find_primary_channel_by_offer() to channel_mgmt.c, where
           it's used.

  Patch 10: Improved the changelog (typo) and comment.

  Patch 11: Removed WARN_ON_ONCE(), added a comment for the case
            nr_chan_close_on_suspend =3D=3D 0.

  Patch 12: Improved the comment.

Changes in v3:
  Patch 2: Add a new API hv_is_hibernation_supported().

  Patch 6: Add a new helper function is_sub_channel().

  Patch 8: Find the old channels via Instance GUID rather than the RELID.

  Patch 10: Add code to clean up hv_sock channels by force

  Patch 11: Add code to wait in the suspend path: all the hv_sock channels
            and sub-channels should be cleaned up first before Linux sends
            the VMBUS UNLOAD message.

  Patch 12: Add code to fix up the old primary channels before further
            resuming.

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
 drivers/hv/channel_mgmt.c          | 161 +++++++++++++++++++---
 drivers/hv/connection.c            |   8 +-
 drivers/hv/hv.c                    |  66 +++++----
 drivers/hv/hyperv_vmbus.h          |  30 +++++
 drivers/hv/vmbus_drv.c             | 265 +++++++++++++++++++++++++++++++++=
++++
 include/asm-generic/mshyperv.h     |   2 +
 include/linux/hyperv.h             |  16 ++-
 9 files changed, 565 insertions(+), 49 deletions(-)

--=20
1.8.3.1

