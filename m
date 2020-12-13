Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE282D90D6
	for <lists+linux-hyperv@lfdr.de>; Sun, 13 Dec 2020 23:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbgLMWHy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 13 Dec 2020 17:07:54 -0500
Received: from mail-mw2nam12on2104.outbound.protection.outlook.com ([40.107.244.104]:41605
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729343AbgLMWHx (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 13 Dec 2020 17:07:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrZHbDnrZ2UjsXY6ULyo4hO2vgppKJqeszD5CXvuxYT5xosRxW+MmMx2eZX3XG80pof5LfCI58/53DblLfsGFtVAhUlrvHGbNXlF1C19XRICyJGTgiWVBa9TxddV9nh6A361/GScQJSWxgbDH2OaW1fRBWEgzwfEtbnvo41t6Z0dxy98k9qFp0jXCzCJ+uHudg1wOIh/+n0mH9BePFUg1bWlnmyuO8BElIqZO096+m8CtyAQpRJZEMtwmejK9K5ggQ9jmcz1KR6YPzxiHajdZGewC/YZjEy7PJ9QS+AS9N+AdtBZ06qzcD7N5anosDHS6LpuPvyD8Me6OScsox9vrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCx5pHxVFwEVltarzA6jgHp/+s9832htoP3aM8D8szY=;
 b=ZGp95MGyLfEn3XDyPggJKBn0hWPPJDo6lP6xa4RY6myEI12T3ELJE+SIH49FyfNqQMJRO31Hwv5IWUY/bb75Lc7lWMdTdYZeN5qmKWgWOZVylmEdp2XRWcQ3oK7cNQqMGKZ59zeZjRb2sl1Xsj9kHgBUH01mjDqODC2rs0ctQKRjg8Z9E5LMpXrKANVB4LHrYKHw3IGb+OIgaNFybAA2VV+ISTIbP/DhrVb5w4zPvi4yh3O7FSRMoBdz6ofOSuQ5UuOrPmqhzSpJP9VfgNCeszh4o4j+dzNzgIpj8r/BgO7twN+z6ObZJyAmEzYQSFId59aVkk8TRV0IjSyrZxpRSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCx5pHxVFwEVltarzA6jgHp/+s9832htoP3aM8D8szY=;
 b=CQhl6I4AXtabkmpa6OBJODNHi+f81UbopvGRAc+jQ5i66cRZPCh1CklYG5FpN4BOMBoDvBPImCXcCLvaREk7EI8R+DYGImheN5gRqNRKxEZLuoqAMjJwh8gM/2PqwJMeurEVqllVD7IrlCvZqnjXUQYNXVse0HhLF7Yc5vwdbmo=
Received: from (2603:10b6:302:a::16) by
 MW4PR21MB1858.namprd21.prod.outlook.com (2603:10b6:303:73::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3700.1; Sun, 13 Dec 2020 22:07:06 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922%8]) with mapi id 15.20.3700.004; Sun, 13 Dec 2020
 22:07:06 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Andres Beltran <lkmlabelt@gmail.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>
Subject: RE: [PATCH v4] hv_utils: Add validation for untrusted Hyper-V values
Thread-Topic: [PATCH v4] hv_utils: Add validation for untrusted Hyper-V values
Thread-Index: AQHWtoAcDIEWdt1fOkqLya2qviZkrqn1yz0A
Date:   Sun, 13 Dec 2020 22:07:06 +0000
Message-ID: <MW2PR2101MB105203EB0E4889F2C716CE83D7C89@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201109100704.9152-1-parri.andrea@gmail.com>
In-Reply-To: <20201109100704.9152-1-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-13T22:07:04Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=edb22038-260e-4889-906e-4ecc6a8c388f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 98f87a9b-56a0-4ce4-cd11-08d89fb36dfe
x-ms-traffictypediagnostic: MW4PR21MB1858:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB1858F8C37E90252D762AF55FD7C89@MW4PR21MB1858.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y5fHqQjoE+553nsgpo4DjDwUMv/kBcLbFK+wDHN3x8pHn+8h+O58DexjMBVpbN3KtXSq0TlHygS312A7OU0Ymm8x2qF/sOq5ZsVJjbwnC/g2pRrkX/gYDcVY8wySVNrbk2S5PNu740vwgKQN+b/RGWDeUkDWhNmRNQBUIr+gTxI220+f/kCm21ST7HTB67OwJpDjCZ4v/PUvJ/xvHbYI3fw2eDEDCaDEZJu/03Rk0QjN++NHfC4hhbkVquaDuXxkuSEoTo5zM1UkgzIHtBepgjfBnKXqxo4TQD89GZ+xAmXeJYTS7BqW8Q5JEUB+jdcMegqBGJnFpt/myUhRSUUq4x6q9dM9j0j+MIOovyWCSxNOS+IWcinkc1iLhwNyVSihVUTWjTJwH+xux8KrxM1/oQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(5660300002)(33656002)(86362001)(2906002)(8936002)(8990500004)(110136005)(83380400001)(10290500003)(7696005)(508600001)(9686003)(76116006)(66476007)(66946007)(54906003)(52536014)(8676002)(26005)(186003)(66446008)(64756008)(55016002)(6506007)(71200400001)(82960400001)(82950400001)(4326008)(66556008)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uunXObMMOwLPtV/yDntodWWozmV44PicQ5ycO5tzhlajJYvE3R7UhW6s8Rfp?=
 =?us-ascii?Q?3ddDrp3//WLfldy2k08y+B/NNUofU9lhhC+1OH/CXx8SsLCrQBQlrbqHrBGp?=
 =?us-ascii?Q?KYIjDRtHzbe/2GelAxadcGrtxdw/kox3tKaprgiOSASiyi5gpbfoV2+ahalK?=
 =?us-ascii?Q?+TOYfzQt3gBs3Iknzbqb7P4y+7BOEwGwkhdM8FBNre1cSYP4chhYUrTdLsTZ?=
 =?us-ascii?Q?oeFL5QYpCdRSmZnBBRhUdLlWsv7qFzA65eXPndzfE+2b/jvUm1eKveLO44yw?=
 =?us-ascii?Q?N9BiZtDJIt4rBWoIHPAc2qu/T6GWWSQ2s/EQLEEHch+cKkCtz5QPkdRGkOGT?=
 =?us-ascii?Q?K+WHDQvasXC6g2EP1/WGdwtBYbTwijt1DRb+Iz2wvZ8IDeLKlCVhc2bmJjKa?=
 =?us-ascii?Q?uwDz/qUHZahXVedLr4jRrKN4/k+uMre0Nvdqcy47cb/+mBTvbbg7MbKTlX+P?=
 =?us-ascii?Q?XkkcgdP3nMnZuf04o/0hCZglgcyxkPbIokx4XAiSZbWAv5yEnY2HZAyUQtYX?=
 =?us-ascii?Q?1Zdb2wxBQQqGczFU1qGXVyIeEu9LhUfPFwXTeKzWpAX+FUglS8hP+0657SdT?=
 =?us-ascii?Q?0XPtaOIDPR9Mp+gokTqOHx6KGhqx4IQlJIyKyPqzPYtxbY5XMwEb25wxrH4P?=
 =?us-ascii?Q?OWiVm+Jjiq88E7p6SUhtJQ7u4z8NgYM1JepDgOulh7yaw0ZRqi4EStx9KjzF?=
 =?us-ascii?Q?fyv805aR4Z0UgcslGNUVWDPOnO2M6ffbBkghr8PKGK7ykKNonvRzlWgrTMBJ?=
 =?us-ascii?Q?O3RD8nozJTT6vebh8HY/GVQxsw+z/xooVopbUw4RbrganXprfBVv+y5agsJ/?=
 =?us-ascii?Q?9JJRNvHemTy9p5CJixxzaXl4ZA1SoJWZOyFmy5wNcwJw+kGp97R/2YGVsNCh?=
 =?us-ascii?Q?Yj3sIwpA95kkTrlv8Ok5+UIyaAdQ3TlbhgH/d9Pv3LJPIKmHYfL3Q2J1W7Km?=
 =?us-ascii?Q?9uheCnzmMfpe8z1Eqh/pKDx4WlbuQvyClKKHtiIbk74=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f87a9b-56a0-4ce4-cd11-08d89fb36dfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2020 22:07:06.4663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CTUduztC41OOn4885uMZ1p170fFOGxIZ/xMgm9nyLMqDExg7sLoQA9ZalPkkRYQgiSE9ezB8U3CwUKrVpFIYjbtwe1GiZpPkmnJS7VWjrrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1858
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Monday, Novem=
ber 9, 2020 2:07 AM
>=20
> For additional robustness in the face of Hyper-V errors or malicious
> behavior, validate all values that originate from packets that Hyper-V
> has sent to the guest in the host-to-guest ring buffer. Ensure that
> invalid values cannot cause indexing off the end of the icversion_data
> array in vmbus_prep_negotiate_resp().
>=20
> Signed-off-by: Andres Beltran <lkmlabelt@gmail.com>
> Co-developed-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
> Changes in v3:
> 	- Add size check for icframe_vercnt and icmsg_vercnt
>=20
> Changes in v2:
> 	- Use ratelimited form of kernel logging to print error messages
>=20
>  drivers/hv/channel_mgmt.c |  24 ++++-
>  drivers/hv/hv_fcopy.c     |  36 +++++--
>  drivers/hv/hv_kvp.c       | 122 ++++++++++++---------
>  drivers/hv/hv_snapshot.c  |  89 ++++++++-------
>  drivers/hv/hv_util.c      | 222 +++++++++++++++++++++++---------------
>  include/linux/hyperv.h    |   9 +-
>  6 files changed, 314 insertions(+), 188 deletions(-)
>=20

Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
