Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BEC520987
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 May 2022 01:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbiEIXrU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 9 May 2022 19:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbiEIXrD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 9 May 2022 19:47:03 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020019.outbound.protection.outlook.com [52.101.61.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02192CBE49;
        Mon,  9 May 2022 16:37:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlZMf6BQXo2JnDeihYrzVrFhvTIvMO5FsiWu0ZfoYluCY7daZ6Sh2OIeISw3F939BaiCcxArVLA/SPuLNgY2HZ3+5a2EuQtw4jh4SVikrOrko3rqfdDUQQ8EkX72CAXPXyZpbpstLkA/I9bxweTC617L/OXzXO5Uso1ZI2j1tlfnfLOKywEjfp3tRlkjzx7MgNiSBf1CkSJ60nhc9Y2z+6hdA62yUqkBcc0olFOMN8pljgsXtuyQsNO/zLupOagOkgcigAd51EZIIRxhkxrkTBD4AZw7PoWzeK38YZUvbgpC5XKazRLZcWEJqyLYdvTVStxhJhKluYfSLLdTAdhnwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2boRma8GBjEHqTPzWPN6YMXpqxhsgGTYSTCuLR6e60=;
 b=aIWOOq8gWp1nomKFVn1SCW6BfEakNzMF2wRuR3J6CVhrpF0SWYq8YHpPUq/PryMwauH8owKqCq3TyYuwD5r8S4AJ+i+oC/qngRfXNOLnFkEIuISjT12OdPAZU0FJbfo9Xg4J80TevQU/m0tYOA+UpaCUGBr9YWjpP5nevkz8+qHYlcw55d7FNk0xtMe8oNn6DQeYPi6fHp/s2JmeJsIIIFznjH0UrRg3HwBVoMzlM7rf/MzTvDkokbQEGWmIPJ95H5Cvu/NLJxMX8mzVxG10755I9/VOrQZoshbVx0LxDDFMwqzJyFrT8S5IHx1C1BHBotwl2mwU6K25moM60QK5sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2boRma8GBjEHqTPzWPN6YMXpqxhsgGTYSTCuLR6e60=;
 b=PragVpiGQh0dmHKIfvFJppOgpKltKAtR+IulSAd0N1/tbGDdZz74v/Qn7uNyA3YuKM2NXp/kC6hy91S3PzeVUWOla4TRJQaX8ays5/1eBGGb0oEFizMWprYoZxIIttbwK4PPXaQqsmaNMFx5EoO3DSUa4PCz4du/8JL/9YS1EA0=
Received: from BYAPR21MB1270.namprd21.prod.outlook.com (2603:10b6:a03:105::15)
 by SN6PR2101MB1614.namprd21.prod.outlook.com (2603:10b6:805:54::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.4; Mon, 9 May
 2022 23:21:44 +0000
Received: from BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::e418:c952:c12b:dcaf]) by BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::e418:c952:c12b:dcaf%8]) with mapi id 15.20.5273.004; Mon, 9 May 2022
 23:21:43 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     Jake Oshins <jakeo@microsoft.com>,
        David Zhang <dazhan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] PCI: hv: Fix interrupt mapping for multi-MSI
Thread-Topic: [PATCH 2/2] PCI: hv: Fix interrupt mapping for multi-MSI
Thread-Index: AQHYY/uLtrf92CyMR0yuD2I97iIyaw==
Date:   Mon, 9 May 2022 23:21:43 +0000
Message-ID: <BYAPR21MB1270DCF4AE2A64520E59235CBFC69@BYAPR21MB1270.namprd21.prod.outlook.com>
References: <1652132902-27109-1-git-send-email-quic_jhugo@quicinc.com>
 <1652132902-27109-3-git-send-email-quic_jhugo@quicinc.com>
In-Reply-To: <1652132902-27109-3-git-send-email-quic_jhugo@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0de8b603-8819-49f4-970e-8fb95077e794;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-09T23:13:46Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09cefa35-fe36-4e00-03e1-08da3212ae14
x-ms-traffictypediagnostic: SN6PR2101MB1614:EE_
x-microsoft-antispam-prvs: <SN6PR2101MB161482BEEFA541B127E43F66BFC69@SN6PR2101MB1614.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5GCTTTiGBUHygtge/pd/HWmxTdQnxqB/djQ957bh7VDeCoP0fALeAqXmLFRSTPpA2bM+asYbsCXc2zoV5s9yjR0gBpGlmRgl9nFo4+Z0PIQjV8Vu3MJK/HcMq8+6e76s5k6kOj0HWlJSaNJ4Da0I/YevdTjLWQzO5OWgHJmkWKcqfKQPA1p3BXUb2HA30AGv/8oJMLb5wp2X9aCGjBE8xdAc5LoONXKxWi2WtSkal2bGku31ufPf3u+oE/EM/sN4RX3JW2Xp/TZUSX8Kpz46lKxsuT1cvN25lAeA8BltGHbJov9/z/qDxFv1+pacId54gT4TyqsDh2dcd7D9cpAFFVbSqeJK2VBDq2s8PIt27vZy+VI8vxvfypaKyBxChtg4k/YjfG822rLSUm1UNWNf8fVK90kqFODVvoiKSytwutyYoPspCF/NeuJ0OinP+fNp3ptniq2Ki6cVSXDE/udSAoFUapVDBnIyzg9HMcTC3qgn/zAgqA2uLOGtzAQUI+hK4kqtrlfYOqBQ5BuKInlKW5h476kl2iJRCsAZk9ridyCdAQJuXyehhkUFreer6M2uNX5W9/v6WzgUiFkJh9L5lGEiF1oJeF1EpdIQyLBQrPvDNlmD1DlirFOcdn9L0xvzHSn5BgxEa2y2aVeIT6eS2bgBxHlCu0FpV99+a4Hf5t/Z6JqEgloiQZ1ftmZYvlYvDlpDzk9jYi5px4JTDA3tIvfnVm8lorPgV7KDclV3/xvI7xVkis7cMVCMESDE9z5t
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1270.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(122000001)(186003)(83380400001)(55016003)(7696005)(82960400001)(26005)(9686003)(82950400001)(86362001)(6506007)(66476007)(316002)(66556008)(8936002)(10290500003)(4744005)(33656002)(8676002)(110136005)(38070700005)(4326008)(38100700002)(64756008)(2906002)(5660300002)(71200400001)(54906003)(508600001)(8990500004)(52536014)(66446008)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TrYzkA+PMjKregf+atAOFKfoUuhwtudO+GCw5h7jlRU7hTZnacGuH3zf2kkl?=
 =?us-ascii?Q?wO7pri2JjAvNMl3ths+wJiCNht1+cvH/+kAOPz7lAXxxyLCt/7e0jDHwZL1M?=
 =?us-ascii?Q?nwB9YuVTBX6JvJg7QEZQ7PxwMnFfcuKqggccnrAI9eUpgoiOfaIs3cmDGK8c?=
 =?us-ascii?Q?xrrDEP1CWyCKXTU6K5PO+KA6Z4iYheYba+CBwaqlFTB0B6Y01VZTFk5Q+3yu?=
 =?us-ascii?Q?UhIB9yhXhUY3aSpBe6+aeNScRxjnksErqCTgRJKXF7E+80LmYT6DC4MGhWqg?=
 =?us-ascii?Q?nBSFvbVWx131ZcUOZsJ0dyL76zNt7mhHL//j2fh6I33LXdNivDepxz5071W3?=
 =?us-ascii?Q?KgVopgLzbd+HXetagg21JfJhBdZJ6YiJbKGf+lgSBoQdE+jJKpFb7NSU1o8r?=
 =?us-ascii?Q?HxRTOvLCR8fxsaZ6B54r7VDsAk2Ew4jl1l6t6K2Fub+nuVdAT0Ip/eDVtLCR?=
 =?us-ascii?Q?v9aUpV5m5OeJ6I9fu358toz+3iuE9mh6jA8FjzfC9QE42RUMk+W/JiA8guuw?=
 =?us-ascii?Q?DlndXXZmwtUH0nyfBJutORRehJIzBSYx8cjSa/e/q17nRTYRF2f/3d0XM6Je?=
 =?us-ascii?Q?5AZ0a4kq6z6TH2JQ/zr1M3fDzgZE8Dqx2nmiP3X8TK6E61AQJmK8YyO+g9q3?=
 =?us-ascii?Q?VnDntgupFBySZDedHlvHv25IajZxQHCATqfZLCMfy3AxYuuZ8Hzq6xi4IJ2q?=
 =?us-ascii?Q?+cS02TLf3VdVf3IpPG/SY/gQnlzgAe5fQJ/OCRt7AwvfEo4NFBakrmgvMj6S?=
 =?us-ascii?Q?ajhlTZXawjZ1UQKnWzLfNeOPaTvlBkVk23TOO+Fk5ZyC37lYW77NEaXPuKNj?=
 =?us-ascii?Q?6unsfEzYt7hJ9OFWTMaPx/GaZt0ErVodxRwBF8Cj91h1CzAWJ8Nwxf8eGs0c?=
 =?us-ascii?Q?CkZCJC5bt8C//vf0dK16aQkMm+IUgIgRBm/cBxvxfaYFE4qsFOiZxK6z0bbI?=
 =?us-ascii?Q?HsVhFhdiicre6LvHEAq9rq4Oh2/WY80BWHDgop/dJCr32c02t1DZKWmFochK?=
 =?us-ascii?Q?sU7AY5TymKE+OQkLPFXUID+AlF+UU1IHwDpqGbUvAfz2CKHSTlOI5ZRg3HiF?=
 =?us-ascii?Q?KHlD1hgoGaQTP+42oaXiWywBzW7K3E6RFhk28+QbjWBomRwNavhyEATZQ32F?=
 =?us-ascii?Q?udlf0boAAXMvTkTQRNlp9qVunf6L/wFLMo8e7DWFxPhBQlJlePBEjvA215hW?=
 =?us-ascii?Q?D4TeMbzGP3jKukJtMx1qW0xmdoJfG6zZJNMGC9SN/WA8WjPKZH1KUveFL3kU?=
 =?us-ascii?Q?+fFBNXDE/K5ggvxlK7Pimp5tQUWwlG+zLU0J4RAlgWuwduDy2clI/uPyOuyb?=
 =?us-ascii?Q?h6BrssG1PGZoyfkLUYq2v9Bwo11q/XSPu5Bs4k2+Vax8GCgbP6N2u9auklo3?=
 =?us-ascii?Q?NMyb675/0xXTp7Qobsyt1tNENUxKcuTpWoe5VFYG5sKvX4Tb2IJD1806Xjez?=
 =?us-ascii?Q?ahJpGErKFlT2E13fftP6r/3HQ705ZyqyAvy8nF5CZ8uoUESRA6DCPuLjTKEj?=
 =?us-ascii?Q?yFBr1rk9VvRV0aNyQcCoy94soL/0Il67kWUQXdiIuu+z+Lc5o7Gm5U1UfcCD?=
 =?us-ascii?Q?CRSu+jvbwK+ZOHVFMFNswbGkrrG3JsPtcjXZ5vN4g36Tvk68IerAY6gbKdn1?=
 =?us-ascii?Q?5G1vp4DMedwYeyFrBwB2Tge2dOtSLWHVF1Voegehe4cV+WGtdqlGfpFR2gkG?=
 =?us-ascii?Q?xqfsVPJokSLTFym9yRCcKTUXJnhzeKmFri3uVyCd42AXNoElGkxktMtbTuoa?=
 =?us-ascii?Q?JhNg42qddQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1270.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cefa35-fe36-4e00-03e1-08da3212ae14
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 23:21:43.7293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D+3h0KbibAfHQ21MYkier8DAS5nj7MXkLo5KUT03uuAlbBXKIjfQcbI6pLDIomO92/XNHynsGL2Cx6GFycra4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1614
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Sent: Monday, May 9, 2022 2:48 PM
> ...
> According to Dexuan, the hypervisor folks beleive that multi-msi
> allocations are not correct.  compose_msi_msg() will allocate multi-msi
> one by one.  However, multi-msi is a block of related MSIs, with alignmen=
t
> requirements.  In order for the hypervisor to allocate properly aligned
> and consecutive entries in the IOMMU Interrupt Remapping Table, there
> should be a single mapping request that requests all of the multi-msi
> vectors in one shot.
>=20
> Dexuan suggests detecting the multi-msi case and composing a single
> request related to the first MSI.  Then for the other MSIs in the same
> block, use the cached information.  This appears to be viable, so do it.
>=20
> Suggested-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

Reviewed-by: Dexuan Cui <decui@microsoft.com>

> +	if (!msi_desc->pci.msi_attrib.is_msix && msi_desc->nvec_used > 1) {
> +		/*
> +		 * if this is not the first MSI of Multi MSI, we already have

s/if/If

