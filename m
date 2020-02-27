Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0D717221A
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2020 16:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbgB0PSX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Feb 2020 10:18:23 -0500
Received: from mail-mw2nam10on2119.outbound.protection.outlook.com ([40.107.94.119]:48865
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729652AbgB0PSW (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Feb 2020 10:18:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdM2Ji5hbZIK3uzZA6XlJXTjXRoyrFEIjGjtmTJDjCqZGCNPPqFjCiBZRcwTX6UxzzyFdlKgBF2QangeYkWhak9ddLscGtqWQRxzqrlEG3/R1G6LCZOoY6O9Ytn9xs/PSYHhUV6MpZUxs9Ksj/xp2bCVV73H49FDvyXWpxEPdDnTb9lnlYwNseRB48A+u384UDfmuIrFFrDaIn1wpaUAiR+fls4ojy2aivO/7+WQVMs93wdAi14Z/Q/jE02AnBnr5uHONXR23QJaR31K4EVLtMGWiZIOvxE3fFRvLiFxKvJx0oXcqBPlfVLokMTdGvZjD80IMs4Tm68GN2l2nNxOIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFadKPQ0Mv0pEgFhF4GfryHlyUw25cB6Ob8ensJugaQ=;
 b=Tg9rySQjduaPvxSdBLgFT1K/8ZRDNWCUhNXDvgKzULnE40KfJK1njH+idpWeB63fZVulI4MmMBOXq7lA6h3HNNTP7RMuxUgw5t/uhG5Nwf8wXQ98UQWAi2Gw0HDmqQeSvYwtinkewh6w3fIQpRD+/IGmWo8+TSQj5jCIRzDTFOK8WLJZVW6x76hD12Sc8IovshRhTjDNanW1kaDE8ckWff5IM/+tXXe9HXNgvc8wdP+dpQJOR7dhtLilzjumJ/7LPkHtBOwHJ8OAzLYitBcrJefJtrFeuoGl8qAiwoR2z/7I3CgqPdNLImxDRHwH9zkLO4QH93eS3YrwIcUDRlbIfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFadKPQ0Mv0pEgFhF4GfryHlyUw25cB6Ob8ensJugaQ=;
 b=JZkJPJ8Gt1ZbfToCzplY62ZMsCzoUSGud4QSD4WeZsnhBXQ25Grihvqhl9ccNogfhYVaiWIPWOXC7YZVwVaRrtIzBpQXTzxKw8RD7fgS+pYH7RwLy/XMAsrAbwi9fM+lH1tBPBR06J3TJd7R/0pQcF4e04BufxW7noA8p1RqTk8=
Received: from BYAPR21MB1286.namprd21.prod.outlook.com (2603:10b6:a03:10a::23)
 by BYAPR21MB1160.namprd21.prod.outlook.com (2603:10b6:a03:103::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.4; Thu, 27 Feb
 2020 15:18:19 +0000
Received: from BYAPR21MB1286.namprd21.prod.outlook.com
 ([fe80::8870:5e3e:13db:9217]) by BYAPR21MB1286.namprd21.prod.outlook.com
 ([fe80::8870:5e3e:13db:9217%3]) with mapi id 15.20.2793.003; Thu, 27 Feb 2020
 15:18:19 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH] Hyper-V: add myself as a maintainer
Thread-Topic: [EXTERNAL] [PATCH] Hyper-V: add myself as a maintainer
Thread-Index: AQHV7M650LATOa+EFkKM7oKHTQUqU6gvJ2bA
Date:   Thu, 27 Feb 2020 15:18:19 +0000
Message-ID: <BYAPR21MB128618BFB38F2145D5AF88CFA0EB0@BYAPR21MB1286.namprd21.prod.outlook.com>
References: <20200226180102.16976-1-wei.liu@kernel.org>
In-Reply-To: <20200226180102.16976-1-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=kys@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-02-27T15:18:16.9837829Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=56fa3b6c-8c4a-419a-ac0f-17cbc98ff3e2;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-originating-ip: [98.232.2.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 73024463-c2ea-4c49-9bb1-08d7bb9846ef
x-ms-traffictypediagnostic: BYAPR21MB1160:|BYAPR21MB1160:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR21MB11603A66B23FAECC32A0A687A0EB0@BYAPR21MB1160.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(199004)(189003)(64756008)(66446008)(53546011)(66476007)(6506007)(107886003)(66556008)(7696005)(8990500004)(66946007)(186003)(4326008)(76116006)(26005)(33656002)(478600001)(54906003)(110136005)(71200400001)(316002)(86362001)(8676002)(81166006)(81156014)(2906002)(52536014)(55016002)(10290500003)(5660300002)(8936002)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR21MB1160;H:BYAPR21MB1286.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /6Qz2tEuugOMGiJ7Ivh8JyWJak+sXJ9VJZ1D1SL2qFTsrZ54XzAA5T4hIcqbwRpSt2TUY0tx1/17wg9X6M8g9xs1iftw1KhXrgICPVHubFfVWCQCiNR/Ydhr+eBug1xTvahjq7indZHAosbg6wiNcnyySSQMqgBz4oW8uLPA7lx9kzdwTS69sD8dI8w/YNTS3L6ABSz0mclnlLXzTV+eR0/P8p9AjlGaul+iHxQs+MhXsOymb1CrLK9ovz48rV380RXFIpo1VHnaG2AKZ3STnGkUJ3+hzLqyG4LSX1hfEtsqtPFFCbA2+oyFIZ1tURo5QngOUpRbQ00mta02+fo0+/zqaYxvDSaB3TJltOU9fyXz+ZUBICjJhG2+lS3TbUCiShYpfn33lJGA7lAWSgfvL6gQzik2Ppi9tZSwxiVibrRTx2R+xirSDKJRcm97S977
x-ms-exchange-antispam-messagedata: 154oqHVb+wLrI7h11D+cxdixFOjRtk450YUb+fjPNJQbEj0DU370myE3rXITMuXFEBvzv0vS4T7jBLff5saD8y7WrgXh37AwxUDtr9t3QREOvubuzHVR2a/B80Ki2uFSTn1Vix5H5JziKOs8VmftdQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73024463-c2ea-4c49-9bb1-08d7bb9846ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 15:18:19.3517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kp6tu5WPSOvncsDqb7MjAurGD9MwbYHLDS1YmV6yV4LZqjHmfKlohhDju4w8359PIOS6H7mv0O8L2uPBTfJp5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1160
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Wei Liu <wei.liu@kernel.org>
> Sent: Wednesday, February 26, 2020 10:01 AM
> To: linux-hyperv@vger.kernel.org
> Cc: Wei Liu <wei.liu@kernel.org>; linux-kernel@vger.kernel.org; KY Sriniv=
asan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; Michael Kelley
> <mikelley@microsoft.com>
> Subject: [EXTERNAL] [PATCH] Hyper-V: add myself as a maintainer
>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
Acked-by: K. Y. Srinivasan <kys@microsoft.com>

> ---
> Cc: linux-kernel@vger.kernel.org
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Michael Kelley <mikelley@microsoft.com>
>=20
> Sasha's entry hasn't been dropped from the Hyper-V tree yet, but that's e=
asy to
> resolve.
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8f27f40d22bb..ed943f205215 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7739,6 +7739,7 @@ M:	"K. Y. Srinivasan" <kys@microsoft.com>
>  M:	Haiyang Zhang <haiyangz@microsoft.com>
>  M:	Stephen Hemminger <sthemmin@microsoft.com>
>  M:	Sasha Levin <sashal@kernel.org>
> +M:	Wei Liu <wei.liu@kernel.org>
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
>  L:	linux-hyperv@vger.kernel.org
>  S:	Supported
> --
> 2.20.1

