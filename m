Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8E74AA97C
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 15:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242401AbiBEOlh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 5 Feb 2022 09:41:37 -0500
Received: from mail-cusazon11020021.outbound.protection.outlook.com ([52.101.61.21]:60632
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232237AbiBEOlg (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 5 Feb 2022 09:41:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzHU7miJmrLbHhLpbpi2L//INdmX7jK/RVWBdakegXhsIjU3rub808kkAiV9qDr7MSa2tbvg+L4OJ3tMd+FLSuxv+MHBrpviRBrqliu8/BM8SKw5mbhFGcUBBDiHG/1rjSBXoP95ba6+BuYquz6bzoOrqwhef464OXXpmAQ03yEMpYu17KBCyXkl/FDgpAPl2m7IICrA43mbqZJkOkHejDnc71fKyNigcHHTsAFgpn+v9uAf/23g1O9x3YnZM/xvhWF1PjI8qkrv3h00h9BTV/izXejDkvRy2zd4R3thV/Y2WjD9uHrhm27w21yeXGH9mn9+VfM9XCFl79O/1o/oyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AP2gI+gwj8Krnux1hzu3gbHo2hn7GDd/qJHhKE701+M=;
 b=R5pEWyFOhV0A4vr2Yp/UEIOafSjiOeEhnQZrhZEeoz3BF8YzIZn+gb1p57Q813x79hMHs/QeB49qwR03iA3FV3mptAe01KMU042apb7LQUVVPr0Aj+w1VFjXrEQEGDKe1xqApCXW/zlazgioxwoFhAVfeU/EOcTESWtODhcGknu960ApOvk782rGNvzoRf0bO/XiML0LDXrsUUtL5bTJxKMj2haa+YsemvsZ4Oux6nzWxZaM5U1zjDb9gaC3GEG+DVHmafZvrZvlNiDcTydfKTwC4iBbWFJHdvygsi5iNq+hi8l02uVAf/h1soelq63Y85syFjvcR6F0EzNK784Nqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AP2gI+gwj8Krnux1hzu3gbHo2hn7GDd/qJHhKE701+M=;
 b=DYH1hOptgWOIqKb0ZbOJR0fGt37q+M3EuS3+tDetF8jn+CRo4m6f8GH8ig3jXmuxQNdexaInABL5Iqt2b4fquyNiBQQNReG+bRl1FQ+6Mcnae0LyLyaUc+Mqg7/p+bVvA/dzKv4+0nigVCKRSj1rO/ZkiuiiFCDhT2D2/qO0CVw=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by CO1PR21MB1281.namprd21.prod.outlook.com (2603:10b6:303:160::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.2; Sat, 5 Feb
 2022 14:41:33 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e827:5c3c:bd09:4b15]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e827:5c3c:bd09:4b15%3]) with mapi id 15.20.4995.002; Sat, 5 Feb 2022
 14:41:32 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Vitaly Chikunov <vt@altlinux.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Long Li <longli@microsoft.com>
Subject: RE: [PATCH v3] drivers: hv: vmbus: Fix build on Clang 12 failed by
 DMA_BIT_MASK(64) expansion
Thread-Topic: [PATCH v3] drivers: hv: vmbus: Fix build on Clang 12 failed by
 DMA_BIT_MASK(64) expansion
Thread-Index: AQHYGcfiL6mJfsu6ikmY3gkXhysF6ayDjiqQgADJmgCAALDIQA==
Date:   Sat, 5 Feb 2022 14:41:31 +0000
Message-ID: <MWHPR21MB1593FEE0DFE66E1669E6994BD72A9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20220204130503.76738-1-vt@altlinux.org>
 <MWHPR21MB15939EB2A75C96B2287B38DFD7299@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20220205040552.fnshfhin3fij67t6@altlinux.org>
In-Reply-To: <20220205040552.fnshfhin3fij67t6@altlinux.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=468bb8b1-d704-4cfd-85ce-4ae93fad8d52;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-02-05T14:38:35Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d00cb64-2dd9-4ed2-d8f4-08d9e8b59a36
x-ms-traffictypediagnostic: CO1PR21MB1281:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <CO1PR21MB1281368303AF732762094C08D72A9@CO1PR21MB1281.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ad1uDul3dFRbT8lnrCSgjIIFyxDh1NIlcatgpfRfaPqjiDVhzle9pj1dfDeyL/4IZYlGqE4je/ihtrQKkPO0+GuakqdAaUnFfCXtoEkYZ1AkGZ3MaBb59jiiTnNdUkEKcLB8BzAGKas/9A9cO6Ai64TMM3+mJcqITMuSfeUshxIZmLSpr7CauxEyzYF9GgZbeosLtrF99yk5x719SMGFLFBpvHp8HH7KgXTzbRx4OWxop/IVuacOn+/Xtz2PIGvE1qQRdmQgTPZgUUf779r+QM6A91t39eCE2XPC+ZgvDLlyUaAUsJOOF6PBlhyOIuX8epuD9Q16l1IMHckxnsoWXzwiGXs5u30m4VheEqkhQR4opWKluXwsk1ccxWzuV53iabuMCmt2oOsmUNSYdwbReo8Xv+HZ0XLwa+3ZBw8fSfH2cs+XjUTvej2l5pTCRByJV7A9UbQtcHqRaI+iiPWMRJpw1fEkjBdCGNSLV/5rRFYjUIad6X8tIjkxwod2uEjbT/AMTyyyd0qz8u2beDikzNSo2WoKUIv5J2kd9nQqLly/ZrHYiDQhUVIpdOsLGzZKyQX1fK7aZ9f20DC7wSC1STiCzGoeTR4m7R333dHgak3p9BXUI1qVZFMBLozEl7obYNLbvVhOT4bQw7fZkqgXdnzeN+17MB4sJpqterLHi5hGTFevSgbNMVAhpDSf9D5F5DK3mTVvgDoVfuXLHcv5UkTB9eTwE3cBXPxTEqLm+v0qtxjixpTuacb4U853GShE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(76116006)(66476007)(66556008)(5660300002)(83380400001)(52536014)(71200400001)(82950400001)(82960400001)(8990500004)(2906002)(55016003)(6916009)(26005)(316002)(107886003)(54906003)(86362001)(6506007)(7696005)(10290500003)(9686003)(38100700002)(8676002)(4326008)(508600001)(66446008)(66946007)(8936002)(33656002)(122000001)(186003)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dOl0IEnMyNEIrFzwOo7cqcxmktqgn1LLRlsY8X2GTy/4ia97+y5oFpdw8/ZG?=
 =?us-ascii?Q?E6uTWTGLdJrK0u+Kvv+j4tSRyO4x8MaZgTh2XpPowYMX6duvWwjfggCTphqD?=
 =?us-ascii?Q?eSVlCEHU4Dz348WI2qNnpWnCfvGNw8b5ryDBKAIIl7dU8BJ5tVhA1/Qy67Hh?=
 =?us-ascii?Q?y5saiLT3lfL8Ji9h/7/6qbHEAmX4ez4z22AboC21ItIXHZ5gdaF/Xu7/YZnv?=
 =?us-ascii?Q?CRz0OOtRSpT6uGNytgE3iEpLDuENLJdMhxc1bpCu8x7PVm+eyZWsDA1Lr21P?=
 =?us-ascii?Q?6elL+6vqQON3GX/8FhSAQQLT5raTsfdqbkhwHeU9dHZuXB3z/Hd391nYvVti?=
 =?us-ascii?Q?9okPlh6WYBW65Ag4iP6R8TJ6W1EU5a8+53KPsAQSfdv8I9Mt8R29Z9ufa5dC?=
 =?us-ascii?Q?OCRqQ2TxyYScwZvo8SMNzQJHw+5MIMyfdXb+p1rZ9PgFUYPaJ66+OFLv0frf?=
 =?us-ascii?Q?n2dxt8O6HtNeTnun5L54Wo4IBItzT5av6SwUK3TDc0RcOtajdgAE7MHgg5Zv?=
 =?us-ascii?Q?aseJ/J7jyCapPGQnROWrW4vLpvxiVPS67fj9zU97UvyI4v/e9SkRlha7QSKE?=
 =?us-ascii?Q?KE3j6bQigHpdtoEATYkisjnIk9ZuHJ4oAU4bBx724ZxPpDxH/UuQ/+QYAbwK?=
 =?us-ascii?Q?BpK7jwHgyzv++jXw6cHS/2lTnz8/CV8H5norA5dyShgObIO7z2kqh2Zx6boE?=
 =?us-ascii?Q?l7OzszLIZAvEXJTVqWlaJQgbU1gkveFV4L1d1iacRQWP6yPz00TyBk5tpKUa?=
 =?us-ascii?Q?Ysn3FZ9EY5eInuvGUkpxEyGqfWsgLp9GcRwhQRsTEQevodlkrOHZrG2HpWun?=
 =?us-ascii?Q?JODmHBQU+hLfywWIBl4/pV5aC0wM87gg0lfYMWZcXNaWuVAeTDwQLmdwjwMh?=
 =?us-ascii?Q?OUV9EKYF43OPZtWrxIujLLL7Q05vIO8DLQOpAZOxKrWB5sDao3S2vfqZx2DT?=
 =?us-ascii?Q?YrZtjLnE1c5rabOb0XSYpam+pGzJ01i56tv2VabhXE5vTHIF1dqcXxvx4JXn?=
 =?us-ascii?Q?g0sTBcVb5rGTmqDxefs4b46e3ArZkLhCbLFpyiCpU6Sb+CH4gD/JAGVnPN9l?=
 =?us-ascii?Q?cDSlCQvE93SBAAsLh0mlQe0n/h5TAHfAob/6Mv0dnu0ge3ksWZ5Co2i/PCum?=
 =?us-ascii?Q?VA+kvA2NXsUOYquQupKuy14agKfS9R3fli57W3qjeMGlG3VWDyTsPSZJe3Z1?=
 =?us-ascii?Q?7mwuXT9Bh1qccpMuCBAvZtqBaqMsrXXdYx1YY6Jd8KXT6N+Oo3GU+g9Kt9bE?=
 =?us-ascii?Q?cVfHvr+XqW0IdRfTuiVwW0xJYPEjpHhI9dj7pIbf2HLFIAQHjpz5hrAmBRFL?=
 =?us-ascii?Q?K5/rwbngU2fhwwzAN/5hSENDH27Rd1waOCQGxa28WPrDXiz+JGyycrVM3+ST?=
 =?us-ascii?Q?iaYmPVSpr+0AfW+G6ldDg5UmnuV8s3XqwghsayJriOyjzycF6h8/nJyTXk3i?=
 =?us-ascii?Q?c9w28HXc7axQnYQBq1r7iwheuba+0+Er11yQ8VRXyn7us6gTL+yci3HXeHtQ?=
 =?us-ascii?Q?xj05XlgP4BnN+FagS6K9HwOBRYHLmyrK+SfWybPV7kiWrjggbGaO+3147TNJ?=
 =?us-ascii?Q?S0bIJMYEgD9kbzCLnwypG7bE6guxZaMkxM9dqu61Cp5VA2HbRKbJKwFoGT3P?=
 =?us-ascii?Q?fz5vzeWD6CZsGg4UBz3xV7L6uomZzjcSl1cE/Qbn157Z2hXG7qkF783mzTdC?=
 =?us-ascii?Q?WUNdxA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d00cb64-2dd9-4ed2-d8f4-08d9e8b59a36
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2022 14:41:31.7485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GkR8K+/xJtKxoFqZ7zoGRfJ6RpTrxAtYAIVthE3V018r9WQ01qVT256A5ik+S2mzSls1sCEMZxjSYOwT/C/qINljKfNdr69Buv36JLZtPI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR21MB1281
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Chikunov <vt@altlinux.org> Sent: Friday, February 4, 2022 8:06=
 PM
>=20
> On Fri, Feb 04, 2022 at 04:10:49PM +0000, Michael Kelley (LINUX) wrote:
> > From: Vitaly Chikunov <vt@altlinux.org> Sent: Friday, February 4, 2022 =
5:05 AM
> > >
> > > Clang 12.0.1 cannot understand that value 64 is excluded from the shi=
ft
> > > at compile time (for use in global context) resulting in build error:
> > >
> > >   drivers/hv/vmbus_drv.c:2082:29: error: shift count >=3D width of ty=
pe [-Werror,-
> > > Wshift-count-overflow]
> > >   static u64 vmbus_dma_mask =3D DMA_BIT_MASK(64);
> > > 			      ^~~~~~~~~~~~~~~~
> > >   ./include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA=
_BIT_MASK'
> > >   #define DMA_BIT_MASK(n) (((n) =3D=3D 64) ? ~0ULL : ((1ULL<<(n))-1))
> > > 						       ^ ~~~
> > >
> > > Avoid using DMA_BIT_MASK macro for that corner case.
> > >
> > > Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>
> > > Cc: Michael Kelley <mikelley@microsoft.com>
> > > Cc: Long Li <longli@microsoft.com>
> > > Cc: Wei Liu <wei.liu@kernel.org>
> > > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > > ---
> > >  drivers/hv/vmbus_drv.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > > index 17bf55fe3169..a1306ca15d3f 100644
> > > --- a/drivers/hv/vmbus_drv.c
> > > +++ b/drivers/hv/vmbus_drv.c
> > > @@ -2079,7 +2079,8 @@ struct hv_device *vmbus_device_create(const gui=
d_t *type,
> > >  	return child_device_obj;
> > >  }
> > >
> > > -static u64 vmbus_dma_mask =3D DMA_BIT_MASK(64);
> > > +/* Use ~0ULL instead of DMA_BIT_MASK(64) to work around a bug in Cla=
ng. */
> > > +static u64 vmbus_dma_mask =3D ~0ULL;
> > >  /*
> > >   * vmbus_device_register - Register the child device
> > >   */
> > > --
> > > 2.33.0
> >
> > Instead of the hack approach, does the following code rearrangement sol=
ve
> > the problem by eliminating the use of DMA_BIT_MASK(64) in a static init=
ializer?
> > I don't have Clang handy to try it.
>=20
> Yes this compiles well on Clang.
>=20
> Vitaly,
>=20

Do you want to submit a patch with my approach, or should I do it?  I'm
happy to do it, but I don't want to pre-empt what you have already
started without your OK.

Michael

> >
> > This approach also more closely follows the pattern used in other devic=
e types.
> >
> > Michael
> >
> >
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 17bf55f..0d96634 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -2079,7 +2079,6 @@ struct hv_device *vmbus_device_create(const guid_=
t
> *type,
> >  	return child_device_obj;
> >  }
> >
> > -static u64 vmbus_dma_mask =3D DMA_BIT_MASK(64);
> >  /*
> >   * vmbus_device_register - Register the child device
> >   */
> > @@ -2120,8 +2119,9 @@ int vmbus_device_register(struct hv_device
> *child_device_obj)
> >  	}
> >  	hv_debug_add_dev_dir(child_device_obj);
> >
> > -	child_device_obj->device.dma_mask =3D &vmbus_dma_mask;
> >  	child_device_obj->device.dma_parms =3D &child_device_obj->dma_parms;
> > +	child_device_obj->device.dma_mask =3D &child_device_obj->dma_mask;
> > +	dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
> >  	return 0;
> >
> >  err_kset_unregister:
> > diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> > index f565a89..fe2e017 100644
> > --- a/include/linux/hyperv.h
> > +++ b/include/linux/hyperv.h
> > @@ -1262,6 +1262,7 @@ struct hv_device {
> >  	struct vmbus_channel *channel;
> >  	struct kset	     *channels_kset;
> >  	struct device_dma_parameters dma_parms;
> > +	u64 dma_mask;
> >
> >  	/* place holder to keep track of the dir for hv device in debugfs */
> >  	struct dentry *debug_dir;
