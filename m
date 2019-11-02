Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7E8AECD96
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 Nov 2019 07:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfKBGRd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 2 Nov 2019 02:17:33 -0400
Received: from mail-eopbgr1300121.outbound.protection.outlook.com ([40.107.130.121]:6116
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbfKBGRc (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 2 Nov 2019 02:17:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+Du7S6uSi5cJY2QzDCqW7iuEoboS2XTL4Teay42wSObyhkhmh6ZvzQVIohjQOYmCuYB3+HuqyeYMH2DDGJEfGsXQnQiBQAyiJ72BK9AWGQNgxMZNmygsge1LE/3x9oWSq2pPBm7M/dSNqQqsKz3DgIujVAc0BAiXaVCu48xNvlDYgPViGk67+PDZN56VW2SGv7IcREa6jfgh7l4CdUP0cuGx0mWASnfLCHBlJWo2wdbc2Wv4AyFYxeUAb7ZObpVuE5xdCM3zdHHZgURaslDzotSuF6BcH86YRYwAtB7dyr0FSEFYCUgvdj9qnNNdyXkDKhSbugQvHB3gFAI5Bw6wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SO4sO1z+ffKrKW8H3i+vsIhAt/FsBZwTCu2jZkGHcSc=;
 b=ImovqjVAvrORk14lUdbvT7lswIphm09ljgVoBsPZ7yfW5uLWMT4XTZNlNwYFrzRPbo5Z1Rfn7z7NrdXlHOUcVJNFMLd/ZvbUHelI6BYTVc6vYWKqyY6RXG84VS15EtXdViYQChwNPvEx91aXoekuv6jjhOdKfVWfB/j3rj5GwaNVI25fPvrXbmdSU9UTwRmjktLe5l9bsSOhg8kkXiNHpNrKpUEOhl5dQUq0SL53AmRGygTr8xgjW0qdDE3ZtbXFmCl3GZy8hDjoNdptrW+HkYrF9OYpeExtGCyX5W0O8/SuQirc7kbpmh8leUCfsZt8gAOr93+Ky4f5BMgr3+P+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SO4sO1z+ffKrKW8H3i+vsIhAt/FsBZwTCu2jZkGHcSc=;
 b=Dy/nCnuY/t5SB5D9fWj3/pSwvVDWjBTIRvFz4y0img4qYBW/6r15YribGlXYTtqWk8lGlv+NhMbRXxtMzepqRT01Sz8bGoRpAmnSOimhw0f0m7oCLrpMPO99gGGM1svBdhdOCoX57R8+3jBVkyc32E5wWi5pjxFQpQcHp3YMRFI=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0186.APCP153.PROD.OUTLOOK.COM (10.170.187.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.7; Sat, 2 Nov 2019 06:17:22 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::69f1:c9:209a:1809]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::69f1:c9:209a:1809%2]) with mapi id 15.20.2430.010; Sat, 2 Nov 2019
 06:17:22 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Wei Hu <weh@microsoft.com>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "info@metux.net" <info@metux.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "dcui@microsoft.com" <dcui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] video: hyperv: hyperv_fb: Use physical memory for fb on
 HyperV Gen 1 VMs.
Thread-Topic: [PATCH] video: hyperv: hyperv_fb: Use physical memory for fb on
 HyperV Gen 1 VMs.
Thread-Index: AQHViMlWrXYtpApox02C+wFzOSr7Mqd3cNRA
Date:   Sat, 2 Nov 2019 06:17:21 +0000
Message-ID: <PU1P153MB01690579FA52DCDF964AE179BF7D0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20191022110905.4032-1-weh@microsoft.com>
In-Reply-To: <20191022110905.4032-1-weh@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-11-02T06:17:20.0215252Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4eba7dcd-726f-4dbc-aee3-a2c3ebaeee78;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:f1df:b100:5b7:2fb9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7c71a8cf-bc8a-4aa3-ca6e-08d75f5c5278
x-ms-traffictypediagnostic: PU1P153MB0186:|PU1P153MB0186:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB018663BCF459F3D1D197BE2FBF7D0@PU1P153MB0186.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39860400002)(346002)(136003)(189003)(199004)(76176011)(2906002)(9686003)(81166006)(6436002)(7416002)(2501003)(46003)(229853002)(5660300002)(186003)(52536014)(2201001)(14454004)(33656002)(102836004)(66556008)(74316002)(7736002)(81156014)(22452003)(305945005)(8676002)(66946007)(110136005)(66476007)(316002)(4744005)(8990500004)(7696005)(66446008)(86362001)(76116006)(99286004)(486006)(446003)(6506007)(14444005)(1511001)(64756008)(10290500003)(71190400001)(55016002)(8936002)(256004)(1250700005)(6116002)(11346002)(6246003)(476003)(478600001)(6636002)(71200400001)(25786009)(10090500001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0186;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: agcJjU65hYd96Mz4pYn562usIB46stdUd0ocknLZsYReDTi+C1KewR4XaxJnPFtWnL0ieEilE0reWrdeGoipper05wIeOQ8zogG6nIAY2G2I99npwKwPd+mJdMNYUzbCNBNi+RLcd1O4xuiikSil+2wAFZwIGBoTQkCpt2gDbEbBPJqK7k3apW9UX7azev/NUzgiSwhBuKozUmHzLdlZojrnqtnXhYKZQhKBWtk3uufsbG5Ke9bPmSF0HANrKbYQHhfBmPKhUc2vZgM4GS93tCoCHjvd8mPip42KaSXRjvfNQqORiJAq0wc4M5c3Ln6mOHf7llrC0l/n/hdDbNxrSSOpuJoUGWJh0s8q3ryC5cy1Q3x5Jlc77nsC4fdYJmCgGVKPx5JNSSfAveFmbiEmbZ3ts+msX/1BrasGLVKdasgC2yBkCez2d5iw+0VYYN37
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c71a8cf-bc8a-4aa3-ca6e-08d75f5c5278
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 06:17:21.6105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SsM+tdNqUOiLKkfLPm6jswx+wJxwf/BI+oYiY1KA7KbDaZqSNbU4sQBCVJiJMA3ml28Iu9E+6ihZyhAhgCIYkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0186
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: linux-hyperv-owner@vger.kernel.org
> <linux-hyperv-owner@vger.kernel.org> On Behalf Of Wei Hu
> Sent: Tuesday, October 22, 2019 4:11 AM
> ...=20
> +	/* Allocate from CMA */
> +	// request_pages =3D (request_size >> PAGE_SHIFT) + 1;

"//" seems rare in Linux kernel code.
IMO "/* */" is more common.

> +			pr_info("Unable to allocate enough contiguous physical memory
> on Gen 1 VM. Use MMIO instead.\n");

The line exceeds 80 chars.
=20
> @@ -1060,6 +1168,7 @@ static int hvfb_probe(struct hv_device *hdev,
>  	par =3D info->par;
>  	par->info =3D info;
>  	par->fb_ready =3D false;
> +	par->need_docopy =3D false;

Maybe it's better if we set the default value to true? This way we can save
the "	par->need_docopy =3D true;" in hvfb_getmem().

Thanks,
-- Dexuan
