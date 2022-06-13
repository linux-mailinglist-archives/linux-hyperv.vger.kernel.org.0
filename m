Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1666549B16
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jun 2022 20:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244600AbiFMSHY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Jun 2022 14:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244551AbiFMSHI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Jun 2022 14:07:08 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020019.outbound.protection.outlook.com [52.101.61.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61EC42EC4;
        Mon, 13 Jun 2022 06:55:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5OI7uIyZWHQUv3vCvr73hbVDLUxs9WYe0bHs1oEJqE6dxXD2I4RJTLT6cQCkmPul4hZTQEMixNfD4AQq6dG3+WyTzu0ObthGafh2rXZvfEf3uyPjog1jYpNtAyPOij6UFwqBHHjbg/NScp0ghg4DPcuugSMHIhEGa0HP1JLCDlMmzqIwNmtoqHjfNUDR2E1gv0Oi6g/YFuyPsTmvF/CI5KBS4j/J6ar/3T+ox+cWJ+v+OTVsaZacLTGsbJlV61erGl/cxKTQn2ErEuQDTJo3bAmk7VbdqMuojwyfJhEuW4lRxjX3DkRj63F0Lm/peFe843C9kEHc3ncl9J2Vj5/Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbHUfFNO4/m62+S+FKPSqGlGV78HdaCsV/Augm9db5w=;
 b=B9voHddb4P66WvncJP9sdPxgYpRx2YQ/TOOSNR+xJ6/lYzx8HdTSWyK1gvHYPZXJaBNfjMXEgX09rdypdaecQfJIOhzsIL+Rs+vOZ337XMM8E7hJjjqko4vo1AaUEEPnxZKa5p4Y/dVYSTEcwPwvhaq3yTBcTIKY/nQNqi7FXfCwgGinUFA+P7xQIGEKkRYse0WqvxjWflEz0Xx3KwkClKHv5r7Z1saN5LyqHKUZtQD2rdraoyR4W2msrGdePV1Krg1rRw9T4SOZFA676gYE/VVRT+X7K0OU7MzGC7s0be/6leCmGe1QRKBJ5QDykdce9EZpOUoPh4iMkW9HWt3Zig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbHUfFNO4/m62+S+FKPSqGlGV78HdaCsV/Augm9db5w=;
 b=VVXxGt8C4j0KkqjzfiUbNACbcifqLItecm7D+W4XQb+I2cw2xTHBNQ1ClSyfbMvyObsG6uDKiFjJq8ejf0SU9DjiJTWES+AvnQrU7RaK8wc4gOBHPBUkQWvaqQZ+J3pf9Ktt5eiMTLL4fX5ny/cd/+kRD8KUlR7SGZffeTvfD8g=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by BY5PR21MB1474.namprd21.prod.outlook.com (2603:10b6:a03:21f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.6; Mon, 13 Jun
 2022 13:55:15 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::68ad:e4ac:8035:900e]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::68ad:e4ac:8035:900e%4]) with mapi id 15.20.5373.006; Mon, 13 Jun 2022
 13:55:15 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: RE: [PATCH] scsi: storvsc: Correct sysfs parameters as per Hyper-V
 storvsc requirement
Thread-Topic: [PATCH] scsi: storvsc: Correct sysfs parameters as per Hyper-V
 storvsc requirement
Thread-Index: AQHYfOffcwDOvnJng0mq0yy4aXRYHa1I1t4AgAPGGECAAB7+gIAAoPyQ
Date:   Mon, 13 Jun 2022 13:55:14 +0000
Message-ID: <PH0PR21MB3025BB22B32B02C57702D151D7AB9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1654878824-25691-1-git-send-email-ssengar@linux.microsoft.com>
 <20220610163714.GA25982@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <PH0PR21MB3025818CA2E6D9641B878A7AD7AB9@PH0PR21MB3025.namprd21.prod.outlook.com>
 <20220613040557.GA5467@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20220613040557.GA5467@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a888c059-7322-4f5f-b362-3eb7033fd5f5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-13T13:42:07Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba3754e4-8a07-4680-c84d-08da4d4457a2
x-ms-traffictypediagnostic: BY5PR21MB1474:EE_
x-microsoft-antispam-prvs: <BY5PR21MB1474EE4E2D71FC186E55A85CD7AB9@BY5PR21MB1474.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bO/RrNSpjzY5C8I3NSU+P//1w+WxS5DHcbVzK16iBnorhBaKL1GnrvImtp6LjI7t3Sj43B9WTs8ocewyj9FS3Gs2MpHWAhlSuGFaErL2a8VNfz+vqQ+ZPxRd2zj/iMxXNt1+0S9I8OVkbHl2UH2UHS0GOLr/Tdd3RBQOnWQ97FA0uynGURAD12mEZv58LGT71dJyua53Ky3O49BPsBINktxWuYxGdwg+2Y1jm261R/SRPXOpqmuO7AHZco8ZmYCHjNtHH2+Rbr4L9crLPGOjcH7NtCWUHGsRnmtHnjP4VL3588oX15vDWkYE/7te+BsauwbgQJQhm2CLdKgiycnCnWB+shbNGNcA0O5WKepyJCy8AnoGdveyRAU/z93ZfrIEete49m+/mEOtspKaURW7cuLyoZ2ZgvOzpor+a6qNBmDfvLoBjbOZK0D87fEvvSBeJEYe+mkDj2080Hd9Tnmxe8S5BoIfRM9ZfBzU7JreAps7I5K4A3RLwEj0hIsHjJhyObI+hRLHXJfiUkKjQdHeBL1smMtfS/heGvQVp7RQNmB+IwPJSYVQE0aAPo+urQE7Vtz/hZyD2nzXdBBDcD458v8DXSUTIf44KDRdfpHfDeV0b7FH33G4fQNajNWj1D5rZRefze05nMhAr6Xj89wHAQm8yj0jp3Yf8BY5BvS9iWBzlPUNcnCbNZVQUTAHZUAS6qaQA1+A9Nf+MjAjL4S68WBYu+uTpoRbYhoRW25RehKwFgyDlUHWnMm4boRRnOlw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(451199009)(33656002)(8676002)(4326008)(55016003)(6862004)(8936002)(52536014)(64756008)(8990500004)(5660300002)(38100700002)(82950400001)(2906002)(66476007)(54906003)(316002)(10290500003)(66446008)(66556008)(71200400001)(9686003)(76116006)(66946007)(7696005)(86362001)(6506007)(83380400001)(38070700005)(508600001)(186003)(82960400001)(122000001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2T1xO+nxObR6b5ihPxGAbLGMY6YmmBW3O/Gv+A/pgWFSI2ghOqK4EBGO0nV0?=
 =?us-ascii?Q?zK0zG9HEt3V+P7ABiKzjbWpqq/mGjpfjAtZyOoeo+nzghWGIBADLjjFEm0rP?=
 =?us-ascii?Q?6TEHEgnlyo7nY6nFP7l2Psiui351+qzU/xH/w2cuAP2opdM3mDw4JEZwe72v?=
 =?us-ascii?Q?M6feUSI54bYNuK+Cy0coGwh/Ib1s06esgBlCewxRkoGXmM47Z/hEHQpjaDB0?=
 =?us-ascii?Q?X0Xk/JqZ8Nx5oQKUne1kcMdGPtzlOIAK8CrDRrwrpuUUNISvKtcGW78mi9eB?=
 =?us-ascii?Q?LoK1K6wCg8SNT6t3A4QC+HDP/uqaeRPv4yCfW/TwfK7pSVMWXwd+JVPlBMke?=
 =?us-ascii?Q?Tx5Z7u4wsPz6GlksahPO+sLKyAtUJXvg54sfVetMttQZSUTC8X3CknVO/F0h?=
 =?us-ascii?Q?f9J8MJfPN0TPCma9GOKjt6ZuGKxn2Velqr6C28y3y3C2LdGDSJtoYYB/UVC+?=
 =?us-ascii?Q?LbUGGLrXe6N1xxvyKASIysTGzOkVcRN1TuJCRKxzlztzB3n5w1Mc0nzDYWu5?=
 =?us-ascii?Q?PW/Yh1gFsG4d1yMdQXHO6Fse6Q5SYOvzoe9IT4QWdLIoY4zvLXZhIuUqmZWP?=
 =?us-ascii?Q?+hjL4lUqhxKfKz+nVEq36aFmRvMfE6tilXjUNzEQK1zX2PtsG/1WhgXtSj+G?=
 =?us-ascii?Q?soNBM04ro651G+PxQBrFy8iijsiwHiw/Zwn8v3Pv+k0PszTYMhY/rt0nR6My?=
 =?us-ascii?Q?ATGdCVOB6EDoT9ihONwj6Y6mdfr1N/5YLuePG5ZVO+taqIu14Uct7UJrGB7R?=
 =?us-ascii?Q?ofMVd5t9NeCGtMjWBud9N254hMJH4SZvCH5LLXY3aziDovIVsqBlRR9JFhCh?=
 =?us-ascii?Q?w3XBTdSh3NgQzVhNQml10K/zYbWUaONBq/bumd3TytJ4uagr4/2LY6SekpWc?=
 =?us-ascii?Q?F/J+H7BNVIiNIiyTo63w4PeJp8FPFxW+i6PvGFUGoQJ7pwMxpa22JMv9KinI?=
 =?us-ascii?Q?WPagFDLtHzLtbVQbQJVzfJ2G3AtcOjlp7PtEXjTrdUVH0cvII3RztzxEzEDA?=
 =?us-ascii?Q?4aOf09hEcadbK8oTmZU7PUL1GvrjpkR9JsC0ksJT2wL95EhtkXoLDcUdHUAd?=
 =?us-ascii?Q?eXofs2TAtab6LSlsRw5JX1CB78p8CvgQkRX/AoEvKkb20ZPS3rDyQ0jvopf6?=
 =?us-ascii?Q?Yu6Pi/A9A2DgIVenW/pxYYadWeT7XR1mf0cXQ/FjIlrU1vOlpSuhDA51iNnn?=
 =?us-ascii?Q?PHltmAkHkxdP8EB3R9svNFE2HVL6kloHm6Fdvl7LenzCdp+EddCqHR4u5lyG?=
 =?us-ascii?Q?AumhqhmaA+Fem+KI0ZS0kyK1G2/VwqxNRu9zfAJRQkhG9ZBxbVa7atpIPJRn?=
 =?us-ascii?Q?UX9ewIlVFjTLM48BDbH4huoBsE4HJjWKUdrsr5Nn0uVoJI1vWBc8cjlzdHdA?=
 =?us-ascii?Q?kE4bLhzRhn3hSHVD/52vVwRHEhDgSEVrefgseaMYHQc3/w5O/KbIpixqBRse?=
 =?us-ascii?Q?AHI4HCRnsI9FikWrtE0grfd32sNxVqoNhYTgOPOANuQIkmQ5/GDmoeVTs5kk?=
 =?us-ascii?Q?PYWcLL87psOUT9ZndaO7YIEGzfkTy4jBMdnKxmseNxGvV6pOWWfnzfHYrcfn?=
 =?us-ascii?Q?+Ba4BreKXdRT6W0h50TbM92iFoC8IOSH4EkM2S/VNY008jAdvRqR90uSDRrV?=
 =?us-ascii?Q?EiISN3BD2CJzJthCG/BUQsX8HlA/XySL26qRlZp9/T1/pID7ZwXVFYn5mYwH?=
 =?us-ascii?Q?Po3eY6vATeZ+kTB59e4FsRyF8OYJ3+1pwQoB5E1oUJLME4bhMEHQUj807RZF?=
 =?us-ascii?Q?7pdUqQNSKQfnrIuAzf5FkWwfQNNVzj4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3754e4-8a07-4680-c84d-08da4d4457a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 13:55:14.9275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZXPszREiLLMRUHgHyv7y41PsEkx11gnTapzAMx1X7icrNZ0qZBtE73IfstEziEaIfJ/54sSgBCjYA5bQ1MRo2uHhpfqYWs41oIcyOoXXKwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1474
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Singh Sengar <ssengar@linux.microsoft.com> Sent: Sunday, June=
 12, 2022 9:06 PM
>=20
> Thanks Michael for review, please find my comments inline
>=20
> On Mon, Jun 13, 2022 at 02:49:09AM +0000, Michael Kelley (LINUX) wrote:
> > From: Saurabh Singh Sengar <ssengar@linux.microsoft.com> Sent: Friday, =
June 10,
> 2022 9:37 AM
> > >

[snip]

> > > >  drivers/scsi/storvsc_drv.c | 28 ++++++++++++++++++++++++----
> > > >  1 file changed, 24 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.=
c
> > > > index ca3530982e52..3e032660ae36 100644
> > > > --- a/drivers/scsi/storvsc_drv.c
> > > > +++ b/drivers/scsi/storvsc_drv.c
> > > > @@ -1844,7 +1844,7 @@ static struct scsi_host_template scsi_driver =
=3D {
> > > >  	.cmd_per_lun =3D		2048,
> > > >  	.this_id =3D		-1,
> > > >  	/* Ensure there are no gaps in presented sgls */
> > > > -	.virt_boundary_mask =3D	PAGE_SIZE-1,
> > > > +	.virt_boundary_mask =3D	HV_HYP_PAGE_SIZE - 1,
> > > >  	.no_write_same =3D	1,
> > > >  	.track_queue_depth =3D	1,
> > > >  	.change_queue_depth =3D	storvsc_change_queue_depth,
> > > > @@ -1969,11 +1969,31 @@ static int storvsc_probe(struct hv_device *=
device,
> > > >  	/* max cmd length */
> > > >  	host->max_cmd_len =3D STORVSC_MAX_CMD_LEN;
> > > >
> > > > +	/* max_hw_sectors_kb */
> > > > +	host->max_sectors =3D (stor_device->max_transfer_bytes) >> 9;
> > > >  	/*
> > > > -	 * set the table size based on the info we got
> > > > -	 * from the host.
> > > > +	 * There are 2 requirements for Hyper-V storvsc sgl segments,
> > > > +	 * based on which the below calculation for max segments is
> > > > +	 * done:
> > > > +	 *
> > > > +	 * 1. Except for the first and last sgl segment, all sgl segments
> > > > +	 *    should be align to HV_HYP_PAGE_SIZE, that also means the
> > > > +	 *    maximum number of segments in a sgl can be calculated by
> > > > +	 *    dividing the total max transfer length by HV_HYP_PAGE_SIZE.
> > > > +	 *
> > > > +	 * 2. Except for the first and last, each entry in the SGL must
> > > > +	 *    have an offset that is a multiple of HV_HYP_PAGE_SIZE,
> > > > +	 *    whereas the complete length of transfer may not be aligned
> > > > +	 *    to HV_HYP_PAGE_SIZE always. This can result in 2 cases:
> > > > +	 *    Example for unaligned case: Let's say the total transfer
> > > > +	 *    length is 6 KB, the max segments will be 3 (1,4,1).
> > > > +	 *    Example for aligned case: Let's say the total transfer leng=
th
> > > > +	 *    is 8KB, then max segments will still be 3(2,4,2) and not 4.
> > > > +	 *    4 (read next higher value) segments will only be required
> > > > +	 *    once the length is at least 2 bytes more then 8KB (read any
> > > > +	 *    HV_HYP_PAGE_SIZE aligned length).
> > > >  	 */
> > > > -	host->sg_tablesize =3D (stor_device->max_transfer_bytes >> PAGE_S=
HIFT);
> > > > +	host->sg_tablesize =3D ((stor_device->max_transfer_bytes - 2) >>
> HV_HYP_PAGE_SHIFT) + 2;
> >
> > This calculation covers all possible I/O request sizes up to and includ=
ing
> > the value of max_transfer_bytes, even if max_transfer_bytes is some
> > weird number that's not a multiple of 512.   So I think it works as
> > intended.
> >
> > But setting host->max_sectors means that storvsc won't see an I/O reque=
st
> > with a weird size, and some of the cases handled by the calculation don=
't
> > actually occur.  You could use a simpler calculation that's a bit easie=
r to
> > understand:
> >
> > host->sg_tablesize =3D (stor_device->max_transfer_bytes >> HV_HYP_PAGE_=
SIZE) + 1;
> >
> > The "+1" handles the unaligned case you mention above.
>=20
> [SS] : As per my understanding this may give incorrect result for unalign=
ed cases. Lets
> take an
> example of 6KB, "stor_device->max_transfer_bytes >> HV_HYP_PAGE_SIZE" wil=
l give
> only 1, and then
> host->sq_tablesize will get final value as 2. Where as there is a possibi=
lity of 3 segments
> 1. 1KB
> 2. 4KB
> 3. 1KB
>=20
> Please correct me if this scenario is not possible.

Ah yes, you are right.

But consider the case where max_transfer_bytes is something like 8292
 (i.e., 8K + 100).  sg_tablesize will be calculated as 4, but it really onl=
y needs to
be 3 because max_sectors is the equivalent of 8K.

Here's an alternate approach that might be simpler.  Since any reasonable
Hyper-V configuration will provide a max_transfer_bytes value that is a
multiple of HV_HYP_PAGE_SIZE, this approach doesn't change anything
but still protects against Hyper-V providing a weird value:

	u32 maxbytes;

	maxbytes =3D round_down(stor_device->max_transfer_bytes, HV_HYP_PAGE_SIZE)=
;
	host->max_sectors =3D maxbytes >> 9;
	host->sg_tablesize =3D (maxbytes >> HV_HYP_PAGE_SHIFT) + 1;

Michael
