Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D11E5A17C4
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Aug 2022 19:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241271AbiHYRPC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 25 Aug 2022 13:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbiHYRPB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 25 Aug 2022 13:15:01 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021018.outbound.protection.outlook.com [52.101.62.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A301015;
        Thu, 25 Aug 2022 10:14:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBxHnEv0NYrs/R7GL+pDaACIyrBItmSq8xHnqgMRFT7bjXKyinua6JFICqCsfWaVIYE862NIz2Z1Kivoksm9C0H9EUCpZaMKVH77dlReOQ0LBUobf4u8Kw0NhSXhap+veKizZMb3FUXJCP3ZMXWu6bOlXJEzs0YIdMdbnvbYskDWswJbeR4i7XmuSYr63FhbkFqW7nBsKKBc/EovMyIMU6QVdKsyJWWs2iTgADOFzCxcSfUAOOxkom+xB9LwJHokg3OFyIRPtsDV96Qi7i6U55K24HWPCW2mGFPKKmlFU3QWfrREhroRjOiO9DhoOrJXv0ZMWBHCUdQTmvsnfVb53Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yc85sE7akARX88MuR52ObEVtOOpO+tJcLtBIofROW5c=;
 b=IQoggMazxkPmzRt7ujDru0s1+2fuwnOGH7SH4gPl0OW/0QZSWkEuYyXk7a0d7XTx00sVYwbkSjAQwdBOYHOJcgv/CAon48CDHijDsIIx8KAdtFOtFTmKVFK17gBrRwgmaLdWSBSnMco2+pmxQ0ARqQ6f6QjrRTc8v88dRCEyo36D1z+hp1haC022WliFoosXrT3v60iSgJgQzgOI8611mH5cfK2FA2KBpzot42wHfrh8nkjeT29qSXIoX6UccsDq6m+Hm2Bh/QmXeyo6o50rTqWA6XsA85/3SAVSGFWy7P7aAfKzM7SAAsDzFHFfLx56wFVqwWqJhOVC04ijhtdLcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yc85sE7akARX88MuR52ObEVtOOpO+tJcLtBIofROW5c=;
 b=P5OMQB4SH05pWzd7+jKA6p722kPULgP1afm3JWjn1wMfxxi97HKsx+SvVfKck4C7/+UKeFH+X3K/v+A3CefKsTvM8YvUljfUcekz7WWjY22n4uYBLp0/hX940iYUNFQs76g+te46UQKHUqc98U/PvEYYVloC4EPZZCFjA86lKqY=
Received: from SN6PR2101MB1693.namprd21.prod.outlook.com
 (2603:10b6:805:55::19) by MN2PR21MB1407.namprd21.prod.outlook.com
 (2603:10b6:208:204::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3; Thu, 25 Aug
 2022 17:14:56 +0000
Received: from SN6PR2101MB1693.namprd21.prod.outlook.com
 ([fe80::6485:465a:309a:2205]) by SN6PR2101MB1693.namprd21.prod.outlook.com
 ([fe80::6485:465a:309a:2205%9]) with mapi id 15.20.5588.004; Thu, 25 Aug 2022
 17:14:56 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Zhou jie <zhoujie@nfschina.com>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hv/hv_kvp_daemon: remove unnecessary (void*) conversions
Thread-Topic: [PATCH] hv/hv_kvp_daemon: remove unnecessary (void*) conversions
Thread-Index: AQHYtqL1LmM8wOEICUu5pPDyJKO6062/3fbA
Date:   Thu, 25 Aug 2022 17:14:55 +0000
Message-ID: <SN6PR2101MB16931A789DA8673E9607F761D7729@SN6PR2101MB1693.namprd21.prod.outlook.com>
References: <20220823034552.8596-1-zhoujie@nfschina.com>
In-Reply-To: <20220823034552.8596-1-zhoujie@nfschina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=29b33f71-2072-4ba0-9e97-779f9d1350ae;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-08-25T17:10:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7e0e38d-3962-4498-386c-08da86bd550f
x-ms-traffictypediagnostic: MN2PR21MB1407:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fglM+r3c/iAIAdMUObMW6mtRW8UQ58gd0/wN0dK1uYhmS8fttOwsipAw07ONSOFZ0LbDwSSTkEkNCLKWC1KMxVSuNeM23hDxcLbGBmO9ghnbQhIUP2t/HmfoTQ/2BzjuBy+lC8m1VS++5WLw3bFG7NBnQqQmthWJY1ag5Wkdd7TwpIT389Wnk6rYHVnbkAZqcTBGfCxsNSzfza/RdxB6mu5pe+VE91HI1AbOVIJPFrcRQ5pNiR2Jo0Oj1ej2f+/PLM6ItCIMa7cB6+RrycOt//B5dR2B/oh3kXz4sPmPjWFhwqHF0AaPBfe/+RJfdTqx2c5LbBKLl6kaqFholaSHsPaeKIQCCNDNqynnMk+xmsO1Cl/XuAEoRbYFBIv1QHDjycTPDa+ZvEUjA8reVqKPPiIUbfSCcn+LF2HIA32fnxul97iDI8PmOAK0FwUSjdY/2KLtswhu6YNmJ8GLWqNv6qXhrcIstbDC1Qd0bt2aV6Pp12712BeIwRm/ykMuW2+LmGESI4xNvCU9HAhmT9aW5Anhy2ToRgLeSCSTOppqCp5mRe4VpYFBOpHBgozzOSv9WDKtGlw9w7g1UdaXa1/wa5cCDna8sJ1XbLkTN8fqT78YXhFhcWYdhdMuKU5tJ7bRBCm5sOKDT/LJ7WKArtGVvl+JXDq6xJostk+ROP1/e7vyGWRXRb+TCt78oTR9S8sLjfZHFRB84IiNZ9/c8gPJ8bICEyLoNSDKAGh/N6g7QIpkXjYuF4avtUKlG9o6IaShb9MJSlwkn+VWNZc7tB5fneuEzZ7fgewRdOa61IZEqjYJ/AHwnuCCWBEQshJjt+FB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1693.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199009)(122000001)(5660300002)(186003)(26005)(7696005)(9686003)(52536014)(38100700002)(2906002)(8936002)(6506007)(71200400001)(66446008)(66946007)(316002)(76116006)(4326008)(66476007)(64756008)(110136005)(8676002)(41300700001)(6636002)(66556008)(10290500003)(54906003)(86362001)(38070700005)(8990500004)(33656002)(55016003)(478600001)(82960400001)(82950400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?czgr0sxSvSt6idQgYdldTiU6qHMC+/TIssPeM7uw7WMMF9OIMfX8dFscXvMW?=
 =?us-ascii?Q?rTwDaUCI0nj67ChgXO5tFxzz4Os2aJHKRQ7hqm8Vtn/bARbZVdccfZMOK/h9?=
 =?us-ascii?Q?wLF7IilvHHh6P5X6M1UwY8PWawPJePuhTMwzNJn17MTMNBjaz3jV6fxDHjM2?=
 =?us-ascii?Q?wL9clFLuM4ikk1ah7fW1i1nT0jzqF5Fa5hSipqlkhR2yST3pICoxcWaxUS1C?=
 =?us-ascii?Q?JlpVP3ak/H0tOdWhXe46h9kyGnCM9KR1MVK3yoxukaTfA2Ht/F+r9TcBpBiR?=
 =?us-ascii?Q?/1m553VwP+QbPKOwzOzrV/MQQRaEEC5NGM4treZkTjrZBZ9M2nB2b275NR3Q?=
 =?us-ascii?Q?FKrq89mbp7Www/x0GDU2ddpeFiBHk+U4tEYG2JzdiZi/Rqx7weCYHppCudga?=
 =?us-ascii?Q?B/HJvwghMf42zeE7ctULJF6XqnCuxisjVJLy8wcOynfpn8d/+fZhCQmqi1hn?=
 =?us-ascii?Q?zj1tKx2zxFYKoY0IHDlQke3usTvAC5G4cWY31b5AtujxkkKrjgCkq9iM4B+D?=
 =?us-ascii?Q?yphxw21LmBCY0bR6/wMHc32hL0lJiKgEsRIj7g2nzXigYl1ByzL6bGUbr8+S?=
 =?us-ascii?Q?AZfhhLvLg+ZYgX8f95gbp1zh22YRwJYChaubdi6pdHj4C/p+gTVNkfxyyVxh?=
 =?us-ascii?Q?VXshOeA2qD0B7an7I2D7eQnOb59PUUfOctu8kE1pd3tbR25c4T/Dg1Ci74IV?=
 =?us-ascii?Q?3dGXkamII4CF3+nM4o3kVxj1nHQZqJEvGx5ZfHK2bCbl4tO9pH+ANbowrnqR?=
 =?us-ascii?Q?trn9eILohOBA2A8pqKWApUpn8/2iebBhX0/ccZJnJQEzkAxvPAdQ4EfZB1cF?=
 =?us-ascii?Q?K+gWZFQS8QWJ6nwhXtGSjyPnSX8jBRS+d/ESTzMUvpb6DAWEg3ZHoxsi9rml?=
 =?us-ascii?Q?q+zrhIjxSr5mzz0dRSXYLEfBSmTFyFNwNIaG3qPkJp9DOIs0Kz8pHafEFdDe?=
 =?us-ascii?Q?GtKFl8nzGVSCrpOEBGRmJ14jy5vw5H6kBS55c6HEwY39/h0kT3Wy5mjKDzJQ?=
 =?us-ascii?Q?OsZBoaFk31ZJTVDfE+Q+2w8aYPbLqaAv1v9NFFUgsSN+P3tCe1lGbbqQnWsy?=
 =?us-ascii?Q?LDMu1b8QnXERBcm08ug8s18pXW1Pbr4mRhCsFRKc/sfFv6gK5EYDFZid+LPz?=
 =?us-ascii?Q?GNOogVILDx41cfqolq/BPRcoElABuGCoLavVeQMLqCQvl8U6b/cJn1ZH9ngo?=
 =?us-ascii?Q?hChYB4jO1QsYbIT1/vUOtbqg5RfFi+ufR/UO39UvptLB0cXJWl/M68/KbQDG?=
 =?us-ascii?Q?HeyPYFjLjYTqcnyeh5ZCAEGE5MxpqZlzccelWH1gXokHSAsOGkh3eJ4U79Ro?=
 =?us-ascii?Q?xwRWhkAlr6+y6WiQTZsg0wAtPbufSZ+gSTvyChnt9ldoUUchOHXOoWxoY2x6?=
 =?us-ascii?Q?nOSqeV0Csqpn0OeXTKLz33vpKG3F8G8gjP3MPZ5jic0eggNY1HZDPuITDH+0?=
 =?us-ascii?Q?wtS2FX6zH+qNM2+TgDFUK/XqCW/cPECksQmyz08UxQyYDrBJGZowsFDMgmJ8?=
 =?us-ascii?Q?y2FIw3nsfMlASzTda+Ms4/iYyIwVsGG42NN6vbv8ui+Uqkkze/ayag9lEPmo?=
 =?us-ascii?Q?8sFI58FnWKvm49Rkq/eNzYvDCTR266koCngrh/OZrXvE88lWhCQEisyWMdq7?=
 =?us-ascii?Q?PQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1407
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Zhou jie <zhoujie@nfschina.com> Sent: Monday, August 22, 2022 8:46 PM
>=20
> remove unnecessary void* type casting.
>=20
> Signed-off-by: Zhou jie <zhoujie@nfschina.com>
> ---
>  tools/hv/hv_kvp_daemon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> index 1e6fd6ca513b..445abb53bf0d 100644
> --- a/tools/hv/hv_kvp_daemon.c
> +++ b/tools/hv/hv_kvp_daemon.c
> @@ -772,11 +772,11 @@ static int kvp_process_ip_address(void *addrp,
>  	const char *str;
>=20
>  	if (family =3D=3D AF_INET) {
> -		addr =3D (struct sockaddr_in *)addrp;
> +		addr =3D addrp;
>  		str =3D inet_ntop(family, &addr->sin_addr, tmp, 50);
>  		addr_length =3D INET_ADDRSTRLEN;
>  	} else {
> -		addr6 =3D (struct sockaddr_in6 *)addrp;
> +		addr6 =3D addrp;
>  		str =3D inet_ntop(family, &addr6->sin6_addr.s6_addr, tmp, 50);
>  		addr_length =3D INET6_ADDRSTRLEN;
>  	}
> --
> 2.18.2

The patch subject prefix for changes to this module is usually "tools: hv:"
or "tools: hv: kvp:" and this patch should be consistent.  Check the commit
log for tools/hv/hv_kvp_daemon.c for historical examples.

Modulo this tweak,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
