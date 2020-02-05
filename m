Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1D61526C9
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Feb 2020 08:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgBEHVh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Feb 2020 02:21:37 -0500
Received: from mail-eopbgr1310091.outbound.protection.outlook.com ([40.107.131.91]:1056
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725497AbgBEHVh (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Feb 2020 02:21:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qso65OO3xznFWl/cEBaYvYe3VjbLyGRu99ox+eaKEAEkF3z93U9Wnphic39u6tUIOLXh/Aa29Aqy+CUNG9gNJI0NrdKmQ+JTudPFndrLeN/+hDhKcnAzrvAg27U4Y/NVsD0pkZ9z9aO2P7kWYBnBzcT+5sMN5IRrD0Sd3X/aNzW6mmCllLBiXlIzvAteLm64ldrQv6Vw7PQ1NY571C+Lwc03wNy4c9qFaM2bxGt0b/pbGMe0Ag9hz4+vH2zo3TbxWfdBqX8jdP893IkRpLVwpmCZ/Hlk6upVzSvc38jRtjnHy+MryncDB7Gzw2CnL9vPluA53dGZEdnBvCVSB2AtvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si8OgVC4jo0U3z2TUhCcxji+Tko9v1eIceAjiWcVMJ0=;
 b=JEeNomUQLb21Z9jIS6cLBjCqE/Veskc59jk6WAsaH9+RGgO774x4n2YeyLbyPu3KOWK2hOXADhQFLoIfkjD4/0+up7QMSo+WeU4SVvWBTukoiIsuviAIoiBJljHfKZxK9iwCYZlvB7yyZZS35Ak7tHdnFx78CYYDPepE0weifL+J4uBg4v3Qu6dW7H2bWeCHVwj21K78jKG0i5757p1M+sqhNZgdRcnnqq5qKRoZtRUWF98DyTLeGcZimqOyFLhelx5cSFSKRTDMDaSqOMXiT2mQgJ3mhDD8U6CiaoelDe66Sv5JZ1r2mOhKCbbaJIvFpV2kWN7JalLMjQ/LkdRY2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si8OgVC4jo0U3z2TUhCcxji+Tko9v1eIceAjiWcVMJ0=;
 b=bWZ9+G3+JiPoNdLuV+OC634Nl+XoxUzx9/s8uPaYX2hy1+2UDP6MIYZC3J4GyvOJ2NfuUavgpGp0VsZhUocWr4Z+yeI62rQ6U5skANkNACTLMwxO37xmg1fBI7urzyRCaIN0jFT34v1SbObdavtTTpgHBZvusIHf4Ly1JnFKqFk=
Received: from SG2P153MB0380.APCP153.PROD.OUTLOOK.COM (20.180.85.75) by
 SG2P153MB0377.APCP153.PROD.OUTLOOK.COM (20.180.84.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.6; Wed, 5 Feb 2020 07:21:32 +0000
Received: from SG2P153MB0380.APCP153.PROD.OUTLOOK.COM
 ([fe80::b4ea:2ab3:3c3f:db07]) by SG2P153MB0380.APCP153.PROD.OUTLOOK.COM
 ([fe80::b4ea:2ab3:3c3f:db07%4]) with mapi id 15.20.2729.004; Wed, 5 Feb 2020
 07:21:32 +0000
From:   Wei Hu <weh@microsoft.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [bug report] video: hyperv: hyperv_fb: Use physical memory for fb
 on HyperV Gen 1 VMs.
Thread-Topic: [bug report] video: hyperv: hyperv_fb: Use physical memory for
 fb on HyperV Gen 1 VMs.
Thread-Index: AQHV2+dTLIiZpDBwxkOf1aO+rPZO4qgMMTTw
Date:   Wed, 5 Feb 2020 07:21:31 +0000
Message-ID: <SG2P153MB0380F76124DEE4F3728C056DBB020@SG2P153MB0380.APCP153.PROD.OUTLOOK.COM>
References: <20200205054359.ynzdaq6lalb2sv7w@kili.mountain>
In-Reply-To: <20200205054359.ynzdaq6lalb2sv7w@kili.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=weh@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-02-05T07:21:29.1628617Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e33c2b67-6a9f-485f-beda-27a7dbb1b870;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=weh@microsoft.com; 
x-originating-ip: [2404:f801:8050:3:80be::b832]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3bafd33-f849-412f-3c25-08d7aa0c068f
x-ms-traffictypediagnostic: SG2P153MB0377:
x-microsoft-antispam-prvs: <SG2P153MB037773F17ACA1830EA54912ABB020@SG2P153MB0377.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0304E36CA3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(189003)(199004)(52536014)(186003)(81156014)(7696005)(86362001)(9686003)(71200400001)(55016002)(33656002)(8676002)(81166006)(316002)(8936002)(8990500004)(2906002)(4326008)(10290500003)(6506007)(76116006)(66556008)(478600001)(64756008)(5660300002)(66446008)(66476007)(66946007)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P153MB0377;H:SG2P153MB0380.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2PtLS1PqNVSjIS0kZvBZv/gHLQrqqJzZ+a83gGJDpTfj5aaXHjobXjjhcZth+1B/nsraGXLp8lszWlkbHKS11bS2RcLFZL5CiE8UQdnZROczUMjc7+hjuUMXXfbYee+aajbCoq3qkSwCPLqwicoYy3xJPb3sDNCW5wwX5NMqOuHyckgu4TGAIyRD/ZpjrFiYchFpEAyMTi4TtIKE9U5NR/ZOg6lbIWbzqQlOhvn3ktj5dhlNyti2tJkh8p2xpAxY+bpzftA3TWWagp9kr4+O6fqMaJpUIZwCDbn1MFdx0Yi+vsxwuMlTSuX5x8RpetYIkt9CXcCROZSbk6YNWywVBP4D/93djZ7goYsC8b/kxwjZ3jAg6U1SqaWW1Ww2pk5jY6l5eFh9Y8oQ3r9CdhM1udTjzTyg3dcHERoe9YDzGd9AMqWDGOzd3jGwdKPpyoyv
x-ms-exchange-antispam-messagedata: 8vAC+ZweS7lhGNkO1RKMSvj4ZqCW1aFiKXLMC1MTAyR77ahEas5Y5uV4HSXqZR5iZ4LkzewZS6xO+rJi/GGPLEhN+HdZDSRnPt3yZ8dRX8m0HjtF0gSLZ7w8mmeNMhrdV6Lxjxktj7AsR0U/RdHL92RTBvQLsGjCFuF4pCycB3Sr7VF3RemiWoCXvEfLjTif
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3bafd33-f849-412f-3c25-08d7aa0c068f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2020 07:21:31.8780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LlwnZuZSNjh7pwcYFPmXQFh4+8m1JjZQPtKBUx8Dj9dhLfzUiuLvT3oF979HMeTQOl1zFktCrkZu9pLZ2NZsGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P153MB0377
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello Dan,

> -----Original Message----->=20
> Hello Wei Hu,
>=20
> The patch 3a6fb6c4255c: "video: hyperv: hyperv_fb: Use physical memory fo=
r
> fb on HyperV Gen 1 VMs." from Dec 9, 2019, leads to the following static
> checker warning:
>=20
> 	drivers/video/fbdev/hyperv_fb.c:991 hvfb_get_phymem()
> 	error: 'vmem' came from dma_alloc_coherent() so we can't do
> virt_to_phys()
>=20
> drivers/video/fbdev/hyperv_fb.c
>    960  static phys_addr_t hvfb_get_phymem(struct hv_device *hdev,
>    961                                     unsigned int request_size)
>    962  {
>    963          struct page *page =3D NULL;
>    964          dma_addr_t dma_handle;
>    965          void *vmem;
>    966          phys_addr_t paddr =3D 0;
>    967          unsigned int order =3D get_order(request_size);
>    968
>    969          if (request_size =3D=3D 0)
>    970                  return -1;
>    971
>    972          if (order < MAX_ORDER) {
>    973                  /* Call alloc_pages if the size is less than 2^MA=
X_ORDER */
>    974                  page =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, ord=
er);
>    975                  if (!page)
>    976                          return -1;
>    977
>    978                  paddr =3D (page_to_pfn(page) << PAGE_SHIFT);
>    979          } else {
>    980                  /* Allocate from CMA */
>    981                  hdev->device.coherent_dma_mask =3D DMA_BIT_MASK(6=
4);
>    982
>    983                  vmem =3D dma_alloc_coherent(&hdev->device,
>    984                                            round_up(request_size, =
PAGE_SIZE),
>    985                                            &dma_handle,
>    986                                            GFP_KERNEL | __GFP_NOWA=
RN);
>    987
>    988                  if (!vmem)
>    989                          return -1;
>    990
>    991                  paddr =3D virt_to_phys(vmem);
>=20
> Pretty straight forward that the static checker is right but I can't give=
 you any
> hints how to fix it.
>=20

Thanks for reporting this. Would you let me know how I can reproduce this w=
arning or
Error message? The build on my side runs fine without such message.

Thanks,
Wei
