Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2880C12979F
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Dec 2019 15:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfLWOlG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Dec 2019 09:41:06 -0500
Received: from mail-dm6nam10on2132.outbound.protection.outlook.com ([40.107.93.132]:59360
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726873AbfLWOlF (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Dec 2019 09:41:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPr2gjPdocBSUASX3P79nnY6QMUznMkVibT19MJiHRVmNnslmoTiWLUYfBxm47i9rqcCaCxVjvlcN9tRO33OkkL/kbymj67YL2ML9OsD0OEvF1I/sP8lH1AyKbmP84kKq7sBc9EhQZSs4uI79zk8yC7QbnyXDiNPIjs06bihMd5egkYt6tHtsa7TgzmF5u0VQkcgSJSD/pCD8e1alSK6CXG21mAlKtW3LqyOVXUr/6RmunRVoDfNaW9TRyVS9bxS8ovofXspIAOtzTiGVBCubouw6eZ27XAmCheDmtiJ8X0bF8L71nGND14XdbENozpdoSXOg8isRqpSdOyG2BxIvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7wPvYbRSu0My075KAeCkKk/RWFtCmcE5R/qJlwHZPc=;
 b=apNgtmpyVZ3h1ngjzu6FtCanhyxhYDYrU52YVnwiQWfjds44bfUZCjOCncvEVDlsTkNgsllynfSVZ0w/oLSw1yyeVs3q/i+BgYCouyx5qdXSf18xSGu2jherPhMF2yuPojuTy9NTX9zCKaBJQjSNAdfMhSve9N1mpCWFgwP+We+TfsLevNuq/0F5WpHKCJJVepWBKQ7bvI4cHMmMxBU3tx7DGtCwe4eyTcsUce8KhsUhzaHomsoraUay+NiOBP4qMF/TIDR9bNlF87ogIq1SVlyDrTiAsh0OJ93oasALWFQUfFrNxFF4G1JK5q0izNIc8VtA7deyNQJJvuwqEs/gPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7wPvYbRSu0My075KAeCkKk/RWFtCmcE5R/qJlwHZPc=;
 b=jK1Aj3CVMeWR86A0Mjk4mfr+rC9ecJ51Aqts+ApTD3+6gI6ufO5/S24uRIPC7/Dk/uFQwNOUqglMI8OQyW7Dj2SwB557951/kviyNuvJbrSh4DA9Db/MfEcE6oY57hmUKDuOlAXMkfk2mhagjh7VyXNnpLDC9hP+9/H0+MHW6HQ=
Received: from DM5PR21MB0634.namprd21.prod.outlook.com (10.175.111.141) by
 DM5PR21MB0284.namprd21.prod.outlook.com (10.173.174.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.6; Mon, 23 Dec 2019 14:41:03 +0000
Received: from DM5PR21MB0634.namprd21.prod.outlook.com
 ([fe80::b913:76bd:45a2:146d]) by DM5PR21MB0634.namprd21.prod.outlook.com
 ([fe80::b913:76bd:45a2:146d%10]) with mapi id 15.20.2602.006; Mon, 23 Dec
 2019 14:41:03 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "sashal@kernel.org" <sashal@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/hyper-v: add "polling" bit to hv_synic_sint
Thread-Topic: [PATCH] x86/hyper-v: add "polling" bit to hv_synic_sint
Thread-Index: AQHVuSBPBL98biB330GIQMjLFcbKuKfHy4pA
Date:   Mon, 23 Dec 2019 14:41:03 +0000
Message-ID: <DM5PR21MB06344320DCF4D3F0CC996BD1D72E0@DM5PR21MB0634.namprd21.prod.outlook.com>
References: <20191222233404.1629-1-wei.liu@kernel.org>
In-Reply-To: <20191222233404.1629-1-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-12-23T14:41:01.4468103Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=be08f4c7-c4a8-4793-80c0-62c5773ff3cb;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b3e0414-3444-40f3-8c3a-08d787b622b8
x-ms-traffictypediagnostic: DM5PR21MB0284:|DM5PR21MB0284:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB028460CA65409671318C185CD72E0@DM5PR21MB0284.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0260457E99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(346002)(376002)(366004)(189003)(199004)(10290500003)(6506007)(66946007)(33656002)(86362001)(478600001)(53546011)(4326008)(26005)(2906002)(76116006)(55016002)(186003)(9686003)(66476007)(66556008)(64756008)(66446008)(8990500004)(7696005)(81166006)(8936002)(110136005)(52536014)(8676002)(54906003)(316002)(81156014)(71200400001)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0284;H:DM5PR21MB0634.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LCunbkzV56H2NUX8DMuw5YqvYdQXHWqoiPSrRWhRKT5C4Tp47lKT2RrYPVBQgC2S6aWvPMVKakqzg/wfsHHp1Ibg1REl/reayOVcCeDE+J/HVyGphZ4DQlDHE5MKapL8sa/7ldgSTqX2cAjEJrF+e1j3+Md6X2+iK50fALIjaVwKsLs+AhG+QsoF8teLs/Y+ANdscq2qM7EzMlvqU+Cs9V056AMWVHwhiVYVuhnjppaXoLStYikG1+gnhzP+Fu900NYE6oqS+mIu5HGBIqBEj/eKBN1sVrPRBM6F25UbzhQJY598SwPmfnfOys7TMbHcC+c3vEJcTnEyLguo7ZCtB0eMT+s0DA6K8EHSWUM8TC2Gw8D8rIUcQIcEjr4exVnirzEP8rXRD4eQe/EbCASII16X8r0z2L0NJ3tvjxLoxgPvNq7HHcJu9Iu4Aadjx/bP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3e0414-3444-40f3-8c3a-08d787b622b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2019 14:41:03.1252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gViVUbZ22qSSQK7f5zdGyB0M7I+X+G3bi4c5IYJZHAVFBXbA9MAyi/QOHlFlGYMfxepzcZGZGwrDEeR1ruAmxOK5rAtFFZYt3bh9jG5Yk3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0284
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Sunday, December 22, 2019 3:34 PM
> To: linux-hyperv@vger.kernel.org
> Cc: sashal@kernel.org; KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> x86@kernel.org; Michael Kelley <mikelley@microsoft.com>; linux-kernel@vge=
r.kernel.org;
> Wei Liu <wei.liu@kernel.org>
> Subject: [PATCH] x86/hyper-v: add "polling" bit to hv_synic_sint
>=20
> That bit is documented in TLFS 5.0c as follows:
>=20
>   Setting the polling bit will have the effect of unmasking an
>   interrupt source, except that an actual interrupt is not generated.
>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hy=
perv-tlfs.h
> index 5f10f7f2098d..92abc1e42bfc 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -809,7 +809,8 @@ union hv_synic_sint {
>  		u64 reserved1:8;
>  		u64 masked:1;
>  		u64 auto_eoi:1;
> -		u64 reserved2:46;
> +		u64 polling:1;
> +		u64 reserved2:45;
>  	} __packed;
>  };
>=20
> --
> 2.20.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

