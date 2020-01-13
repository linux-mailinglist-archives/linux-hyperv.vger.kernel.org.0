Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F929138BCE
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jan 2020 07:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732572AbgAMG3U (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Jan 2020 01:29:20 -0500
Received: from mail-eopbgr1300099.outbound.protection.outlook.com ([40.107.130.99]:42720
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730659AbgAMG3U (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Jan 2020 01:29:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NW23kI7/SpzBBFO3bo8HEg2rJp9bUkiOYjVR+m8fz876Rff3rH5GVP1TQSItBbLwu4D668wtQPWg2YS5D5wXD65xV8t2B7O6pY5ftfGoOPCs1ieQ355mM4PZ809im4LN/WF85L91EbsdDOYzc+g+xosu5sAduHOdYNs+HHEUwloCBr6fG2j7r7+W+7bnYi1Alqo2/54ig8ocatpr98Qd9EwNv2Zdj8S1TzcBsf5Arxw9buuVehbNCQ2in8mVObk8S+5rVaGOI1DxVfHGyWtRmqsc5GgJopzmnow5fMT2pVA1XEeKtnPmMqww5wRSEjvkp64THtbgDEJPh4lXgk6s+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4YvIUwKojbdBAXmYyO9nnS7OqjAieXi5eKK6PYhiTU=;
 b=IeKf7qK47jQgio1UgbyOfa4yf7vNf4pTBHFwdxdKoqCOeb5yRKlPRzqw6EUe/RYHWDkWR2VZiEpkCSz1QV/S7knvw51zgs9Zw6sLW1I2D6FqrmlWZNhLaHG8XrJKONoFHv9OpL2tps9jXBiYAM1+korJ2DLFiWo7dd1o8A1iPcyeCPkpHkPw/OuQENjrQidSuYHnf84EW2/7FddARNKmqevPpOZFs2qZWsNJSrAmXTJ6v2dXfi50XYc9UX4kMtwHuw393xyGo8GqDeuDyGajJ+4Er+0r8nqD6qwlAIryJCaMjHJmSMEfKOHGH+ooaKGBWgQdmfBdv7yKXJZraXfM3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4YvIUwKojbdBAXmYyO9nnS7OqjAieXi5eKK6PYhiTU=;
 b=HZHC5UAOrYBsX9cuIq3EEkw+ff6oycjxKUEdaXKjC5AVcJVrkRcLEAHzomYzZFYmxM7D4A648pFAX+mBUcALPfC5rveKTUbLee++Lifq8PRSXTjp6mNbtBxicnn/Zx4OnkvQwx3GMFYt5aMWhyKXb0GI26je3MEkVbdUDwnOLrQ=
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM (52.133.156.139) by
 HK0P153MB0324.APCP153.PROD.OUTLOOK.COM (52.132.237.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.2; Mon, 13 Jan 2020 06:29:14 +0000
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::15e7:8155:31bc:d4e7]) by HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::15e7:8155:31bc:d4e7%7]) with mapi id 15.20.2644.014; Mon, 13 Jan 2020
 06:29:14 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] hv_utils: Add the support of hibernation
Thread-Topic: [PATCH v2 0/4] hv_utils: Add the support of hibernation
Thread-Index: AdXJ2sJyDrPgyG+3TJyc2gafIqgsoA==
Date:   Mon, 13 Jan 2020 06:29:13 +0000
Message-ID: <HK0P153MB0148968D9EFBFAE1E881674CBF350@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-13T06:29:11.3769804Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7131548d-9dec-47e9-bdec-19b34d517361;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:a:fa69:ae29:32b9:aa46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a3de91cc-1894-4c30-1a1f-08d797f1e8bc
x-ms-traffictypediagnostic: HK0P153MB0324:|HK0P153MB0324:|HK0P153MB0324:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0324A24AFA10C2F2374A9F55BF350@HK0P153MB0324.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(966005)(5660300002)(10290500003)(33656002)(186003)(7696005)(86362001)(2906002)(6506007)(52536014)(478600001)(81166006)(81156014)(110136005)(316002)(76116006)(8936002)(9686003)(64756008)(55016002)(8990500004)(66556008)(66476007)(66946007)(66446008)(8676002)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0324;H:HK0P153MB0148.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CHQ6v036j1JVOXeXkMDi8wUh7ZKXO0ElkUfqapK9MH7g6HlJkNNLZBaLgF+UsNbbpaw5gc518dun0vkETw1KeQM29dIKo7FYxHKYas5Uzvuf1AUSswLpSNWd1l5C4c4R6f67Si7B4rnckKRemnYHsy0lGHlMmQnapHwLT28pXastFc1BU9zrA7mH+s/9f76bmkRQ+U7RgUglUlzgXWcPLtTyt050Zl4efhWqGso5fA1yZ6UcKFAsr0VG36jKdtdpQOxaK1gULqK52xnv+LKoDIDq0ADACQzeqN9CACds/TCL4ylH7ZeIz974aGaxYyoPmKhFgJCJD4ZmnIKBocXNoScuoJVHwI+PYUoOSnO4HydNToHzrWpcLtbh7mFdKjeXQO6t8z3wbJJbyO1cTS/a17yAy42Gpq+jVynEmCza1S7jk8pkl+FrjwBkvzLzyT66OIAhlIxd8WNB0e868FeLN4RLKFPrDIAorfdfqRQ08TU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3de91cc-1894-4c30-1a1f-08d797f1e8bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 06:29:13.9371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gEIz12xJG2n6wv/sR9bPElY1mXN0luQiz0XwYfquKB9Z9RQacPMtMLzqxCfpboYX0gFdC7jFVQKQ+ULgqhf3kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0324
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi,
This is an updated version of the v1 patchset:
https://lkml.org/lkml/2019/9/11/861

Patch #1 is a new patch that makes the daemons more robust.

Patch #2 is the same as v1.

Patch #3 sends the host-initiated hibernation request to the user space via=
 udev.
(v1 used call_usermodehelper() and "/sbin/hyperv-hibernate".)

Patch #4 handles fcopy/vss specially to avoid possible inconsistent states.

Please review.

Thanks!

Dexuan Cui (4):
  Patch #1: Tools: hv: Reopen the devices if read() or write() returns erro=
rs
  Patch #2: hv_utils: Support host-initiated restart request
  Patch #3: hv_utils: Support host-initiated hibernation request
  Patch #4: hv_utils: Add the support of hibernation

 drivers/hv/hv_fcopy.c      |  58 +++++++++++++++-
 drivers/hv/hv_kvp.c        |  44 +++++++++++-
 drivers/hv/hv_snapshot.c   |  60 ++++++++++++++++-
 drivers/hv/hv_util.c       | 133 ++++++++++++++++++++++++++++++++++++-
 drivers/hv/hyperv_vmbus.h  |   6 ++
 include/linux/hyperv.h     |   2 +
 tools/hv/hv_fcopy_daemon.c |  19 ++++--
 tools/hv/hv_kvp_daemon.c   |  25 ++++---
 tools/hv/hv_vss_daemon.c   |  25 +++++--
 9 files changed, 344 insertions(+), 28 deletions(-)

--=20
2.19.1

