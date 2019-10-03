Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54F4BCB221
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Oct 2019 01:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbfJCXGL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Oct 2019 19:06:11 -0400
Received: from mail-eopbgr760131.outbound.protection.outlook.com ([40.107.76.131]:14844
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727452AbfJCXGK (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Oct 2019 19:06:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEVHX7gH+pxdZ8yjbDAUA0++qPDsjYwJLhN09rfS2yBhxonIo1fzzxazw5BUmG5AdexbKoYf1G622vsW2vPKKCktBGmquL4h+e/ufd81+3rQQatiTKrlmWAxQ7o5i/dvIaBndfIr7KoUuX7OpfPPGmiGIuMyEIXGvI5w99J+FAKxdlaEBu3BRFVLGwd35FgWJ72drbF2BfzrDIOdsSHQL+g559xyk1W/0Zr2Kc01Roi6pxY3bYg60z+UqRH88x7RFP+HGO2ZN02bdxR1DftK0gurAtSNGrVa/u0g7qW1DNHfG2L95gKwPAc9BFtd8GfFQ2vk4y3XQSzfFWgmDfyZww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFsfbBf9p5NvIpQVulQ7lBuFNpyZE+dpv6TRmbeOIW8=;
 b=j4QZx3/FVNNo5xWlIgZqitkKLGHVZCcVTHqipypW6KP3xYef5TKAlDwbonVUERT+JkNmETBWNadfeIvpLjsAgPzpbbL+5Yr7QFPW/LaHPZUHhr1c3c6yoe3mEn38xGZMHo57ZhkGjCqYjeaddswa2YdKsYoneheWmvfZpUU0lAIVJRdh+0kYeQDLtcB3ZZBiKigw9tSPFUzsD/1ooAqp72oxKrFZOuLdsfzD8eHJ5IHm/CeeiWj8KidoZeGK9Sq9VSPpiOZAngAaMScJLXEf6N8aRCZfzdta6B+QVdYxVrwNOFIMB6LJiryAr7RtQeg1p3tUjvUAGczfY1+4RgpUzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFsfbBf9p5NvIpQVulQ7lBuFNpyZE+dpv6TRmbeOIW8=;
 b=b58XUOGnjYMC3Mu3mdKxtQQaQnrEWnU5m2yzd/Br3SDD/qDwoZAVBiSi4wPpqOdoy+ntZCXhVnflmiGb7oegqi4NLVgHnX7D+WE+/aVpGOwA8QbA+HpGKHjKuiKkvKo94oClrPtH9+wSzHS+BUA1/DVxtb1s9s1fl3kYBqb8wsI=
Received: from CY4PR21MB0136.namprd21.prod.outlook.com (10.173.189.18) by
 CY4PR21MB0791.namprd21.prod.outlook.com (10.175.121.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.7; Thu, 3 Oct 2019 23:05:28 +0000
Received: from CY4PR21MB0136.namprd21.prod.outlook.com
 ([fe80::a849:fd6f:615d:64e9]) by CY4PR21MB0136.namprd21.prod.outlook.com
 ([fe80::a849:fd6f:615d:64e9%10]) with mapi id 15.20.2327.009; Thu, 3 Oct 2019
 23:05:28 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     brandonbonaby94 <brandonbonaby94@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>
CC:     brandonbonaby94 <brandonbonaby94@gmail.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 1/2] drivers: hv: vmbus: Introduce latency testing
Thread-Topic: [PATCH v6 1/2] drivers: hv: vmbus: Introduce latency testing
Thread-Index: AQHVei3JXD/BzUXMhEaGftCyaV0YaKdJiWAw
Date:   Thu, 3 Oct 2019 23:05:28 +0000
Message-ID: <CY4PR21MB0136A1ED299DAA92F9301865D79F0@CY4PR21MB0136.namprd21.prod.outlook.com>
References: <cover.1570130325.git.brandonbonaby94@gmail.com>
 <d3e32c4995c8e4992fab91c3e43c2b0d6a3ef0f2.1570130325.git.brandonbonaby94@gmail.com>
In-Reply-To: <d3e32c4995c8e4992fab91c3e43c2b0d6a3ef0f2.1570130325.git.brandonbonaby94@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-03T23:05:26.3343154Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=992fd9df-ec37-4abe-bcf4-58c01f6b3831;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 464ef189-4758-41c7-3fd7-08d748562ede
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: CY4PR21MB0791:|CY4PR21MB0791:|CY4PR21MB0791:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB07915A2074CD3E3AB88AD050D79F0@CY4PR21MB0791.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(189003)(199004)(478600001)(305945005)(55016002)(1511001)(9686003)(4326008)(6246003)(66476007)(66556008)(64756008)(66446008)(66946007)(2501003)(6506007)(74316002)(7736002)(7696005)(11346002)(99286004)(186003)(76176011)(2906002)(26005)(446003)(102836004)(476003)(229853002)(6436002)(33656002)(22452003)(316002)(76116006)(54906003)(52536014)(81156014)(86362001)(25786009)(71190400001)(110136005)(486006)(66066001)(8676002)(8936002)(10290500003)(5660300002)(81166006)(6116002)(3846002)(10090500001)(8990500004)(14454004)(71200400001)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0791;H:CY4PR21MB0136.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EViOfk9SVdx+OzCMWGT9W+ggfvhBr6M4olyogVYPzi9Ia9JeTxL3S+eOEiIdqL+1z08OS8tUUyGBDYE/QlZLeO0r2RN7jrEzuwNJX3xuDt34feyRwYFyKx86TQfLWifO8Ij7bympZfqLOnp3pqRZSm84ALcTsQF9WZfYmtcyX6Fu1gGoDpBQ5cK9kPjcDmHoUTBVk9hSu8hxrrJ2UrUT9ZpG3ScsSpx0teP07dTij0vEdnp3+y6KV8udmQCCE45kuBopprxkAwPhEIsnLbOUr+PqgzGVTccxOeG3tk0uYHGw8fBCr+ldLkD3zi/67Q24HyrvigJ18yWrkYhgxyYTPV/4htDv2igzXgqbQ+/B1HyAhEPe2tzzpfV8L35oqCQq66ldp6hrmW1siG93U3aqM6dOGtzZI52BWkPcyXGnTH8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 464ef189-4758-41c7-3fd7-08d748562ede
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 23:05:28.6169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xk4VUc62n7kQe/yFcvcadH48pgcNG4TpiICOCG+NO88itKfiO9kZTi6YXkCYVPz1AdS4kUf0iyNgcIXB8ubZhVYtfh/Qqgr3SQ1c0IYgyV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0791
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Branden Bonaby <brandonbonaby94@gmail.com> Sent: Thursday, October 3,=
 2019 2:02 PM
>=20
> Introduce user specified latency in the packet reception path
> By exposing the test parameters as part of the debugfs channel
> attributes. We will control the testing state via these attributes.
>=20
> Signed-off-by: Branden Bonaby <brandonbonaby94@gmail.com>
> ---
> changes in v6:
>  - changed kernel version in
>    Documentation/ABI/testing/debugfs-hyperv to 5.5
>=20
>  - removed less than 0 if statement when dealing with
>    u64 datatype, as suggested by Michael.
>=20
> changes in v5:
>  - As per Stephen's suggestion, Moved CONFIG_HYPERV_TESTING
>    to lib/Kconfig.debug.
>=20
>  - Fixed build issue reported by Kbuild, with Michael's
>    suggestion to make hv_debugfs part of the hv_vmbus
>    module.
>=20
>  - updated debugfs-hyperv to show kernel version 5.4
>=20
> changes in v4:
>  - Combined v3 patch 2 into this patch, and changed the
>    commit description to reflect this.
>=20
>  - Moved debugfs code from "vmbus_drv.c" that was in
>    previous v3 patch 2, into a new file "debugfs.c" in
>    drivers/hv.
>=20
>  - Updated the Makefile to compile "debugfs.c" if
>    CONFIG_HYPERV_TESTING is enabled
>=20
>  - As per Michael's comments, added empty implementations
>    of the new functions, so the compiler will not generate
>    code when CONFIG_HYPERV_TESTING is not enabled.
>=20
>  - Added microseconds into description for files in
>    Documentation/ABI/testing/debugfs-hyperv.
>=20
> Changes in v2:
>  - Add #ifdef in Kconfig file so test code will not interfere
>    with non-test code.
>  - Move test code functions for delay to hyperv_vmbus header
>    file.
>  - Wrap test code under #ifdef statement.
>=20
>  Documentation/ABI/testing/debugfs-hyperv |  23 +++
>  MAINTAINERS                              |   1 +
>  drivers/hv/Makefile                      |   1 +
>  drivers/hv/connection.c                  |   1 +
>  drivers/hv/hv_debugfs.c                  | 178 +++++++++++++++++++++++
>  drivers/hv/hyperv_vmbus.h                |  31 ++++
>  drivers/hv/ring_buffer.c                 |   2 +
>  drivers/hv/vmbus_drv.c                   |   6 +
>  include/linux/hyperv.h                   |  19 +++
>  lib/Kconfig.debug                        |   7 +
>  10 files changed, 269 insertions(+)
>  create mode 100644 Documentation/ABI/testing/debugfs-hyperv
>  create mode 100644 drivers/hv/hv_debugfs.c
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
