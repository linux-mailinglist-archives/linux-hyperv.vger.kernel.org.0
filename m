Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E6555736B
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jun 2022 09:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiFWHBD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Jun 2022 03:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiFWHBC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Jun 2022 03:01:02 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azon11021021.outbound.protection.outlook.com [52.101.57.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD5A4504B;
        Thu, 23 Jun 2022 00:01:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F57X+NoAG2t8/YEg7VcHLvURGS0wSKrAKUFwOkoqMR0ur+Bpc/9Az3NVqu6vng681tg7n5bRu8GwTelihBZXEovR5fkbruSDgYB9rp9vHSlBGStAo557XKb/0NP2qWX141RLpwtEM55HtX/UoZMWAhSz5i6ioJtlfyveCC7J1VETXzc2kCG/ltboydq1c82i3RuF3Q4IykT1blxgg/bkpd0tRsZJ4AmgfxgxuCnN3I0TLiddRUwzKMGfIUlQ87lDDho9hovzIvp0A+20GS+If99TWEBMYUblRLWnyKcuVhaywpQ/YsikyWGG8p6eBaYn0a02M9QuhSB9IowX9IV6DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfQXVynI2NHOAZ8CvhEXs/Li95Xbr94k2VxmhsEVivg=;
 b=jjcPQgQunWS9zO5AqA9su34mEjiCcFK/VHrgVsSydaFiNSchVOkZziG3TpL3z+TRWt65GQ+F8NPneGYX6X75GpaewMwFx6O1cjIQiEIDoEZBQ/klI5M/0KUYJxyISLppQDYcxvUNAMBcCGMzPMbbKojHjvjRWUu1Tih4EVs0NbX04d7Q8JOcWO6UiRsHurfMVxhCjxhHNpcyblSLV6a7UhBmeErvJKfDx5HvSuAj/8rMG/At9BS6j0R3DDcchpfacwISbHJMLqohnz6TVF1x7NKhAyFHmCYt3PKzHWidHgb5SsbvL/RSEYUiWfJe16u0hpFY/5wTWQIGmjnXo9k3Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfQXVynI2NHOAZ8CvhEXs/Li95Xbr94k2VxmhsEVivg=;
 b=E1z+tvmbFg+x0p4mTsRremT3XXX3fwwn3Gt5Ny/TTf3RfkMVxzT37rhH/UurWeoFcRmoqb0/gzekMFeBYS1D2WWPVXtY20OSnN3DyGpw60ivt0e4+R0JZe3MLyFWExR9ZMj7jcYD0Lbu5tge25guDbwol15f6ats6obYOM6gVZI=
Received: from SN6PR2101MB1327.namprd21.prod.outlook.com
 (2603:10b6:805:107::9) by SJ1PR21MB3505.namprd21.prod.outlook.com
 (2603:10b6:a03:453::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Thu, 23 Jun
 2022 07:00:58 +0000
Received: from SN6PR2101MB1327.namprd21.prod.outlook.com
 ([fe80::8d9b:ec7a:4de8:5314]) by SN6PR2101MB1327.namprd21.prod.outlook.com
 ([fe80::8d9b:ec7a:4de8:5314%4]) with mapi id 15.20.5395.005; Thu, 23 Jun 2022
 07:00:58 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Andrea Parri <Andrea.Parri@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: RE: [PATCH] dma-direct: use the correct size for dma_set_encrypted()
Thread-Topic: [PATCH] dma-direct: use the correct size for dma_set_encrypted()
Thread-Index: AQHYhsQ7J6SBfGTcSkmT4EYBsECM9a1cjqbg
Date:   Thu, 23 Jun 2022 07:00:58 +0000
Message-ID: <SN6PR2101MB132705E084BCC12BCDDF4E7FBFB59@SN6PR2101MB1327.namprd21.prod.outlook.com>
References: <20220622191424.15777-1-decui@microsoft.com>
 <20220623054352.GA12543@lst.de>
In-Reply-To: <20220623054352.GA12543@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ce131bb0-73d4-4b5d-8fe8-51b1068c45e4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-23T06:54:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35079989-07ca-43f5-fbb4-08da54e62004
x-ms-traffictypediagnostic: SJ1PR21MB3505:EE_
x-microsoft-antispam-prvs: <SJ1PR21MB35053F58F641220C49ACD7ADBFB59@SJ1PR21MB3505.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b636bijiiYckab9hUG+lAVGxUlswJAYIF6WEboScpyYNCDZR3RteinCEA5AoILoRIaU9WCIqb2bmcx14avHW6xNw6nTOrgHVG+PSnbevi7wpfDEq/MSWT6ArfTVyOfBGp/W1Hb+0zlM2CUrqX1mjobKkm+KUxBgX97gxjfsqhaoJBvOGfR7XIvMznuwApvBfInlweb/sCBpSxwLL8Tc4A1lUAvNR63EJo8/ZjpxyeujbIS8/a7NGWjOdcEeOCCC8Ew1/qzfsVSzcijWbh3grysmEdbUJgnrv/vupujQVwiemL9x8Z4wfj6diVnN1ICKF4kQUwkDGCq2ZcgSvkaqBmed4Q6MMk/5nCjxXViCK8C1aCmI7+pT2PtBsWMt3O52aqiKttCfe1kJtep65pxZo9Iml4WYs7WY++bEsvD65COfB+wKzchEqM2LLAEw31hbvA0Ki14ubtJTbHWSqlvsCuH4TD4YlPJvUJdlLTi/+ihxLoTP0NsHwSiDpQMxzCZqUN7BNmKA7AqpgrAsdU1xRIBJOc0E3ipbpFgn3Nni1iR6XMU61peUPsRs9Zxp7hfxviHCON51T2vzfqAygWDpGx9yK9Xre4Meov1hgebj0F+Ybw83bXDa7pcQl331fa5EADjCwdq5hpWxzuqIjufu4Yio4efhRR8K8qNXrfZoJZjJvvoqo1LzjgqNMtyeuGeSma7rvyc+8E48B03W3pOEO3KLoV66zkmcY4ualEFgjpqy4K2qIm2I7ryLwvHAue7bZclbnIyUvuyt0k570I3/V1KTCLwtnyztwukndLJlwx/ECsm14OpdweucvHJX35DDQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1327.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199009)(66556008)(478600001)(316002)(2906002)(10290500003)(71200400001)(9686003)(86362001)(8936002)(66476007)(5660300002)(53546011)(4326008)(107886003)(8990500004)(26005)(41300700001)(6916009)(52536014)(66946007)(8676002)(66446008)(64756008)(76116006)(33656002)(83380400001)(82960400001)(186003)(54906003)(82950400001)(6506007)(7696005)(38100700002)(55016003)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: Arf5NB2IZbuT1z+8jZu7ImAC8letZALa2mME9Qswi9SC+deNhZiL4rr53vs1kyfqKO+NctyL5TyGJz9C0TeFmcZ13O9NS6I4NwNtjpr7P2Kbs1Mf6YQ3eul9Exuhyxnas8rBUjc5XfWPhCy9TPH8hgMoMZQPAiBoTAuufmxoXFG0g2VUCnX8CnhFERsmHtyKmze1/heEGEdDs+p9+5KD48HA8LMeD44hPGCQrJGAIFRfRie1HD7B3CCbxT/8EgUaYQMNqTrcKMadEIh8SyychyZop9RUS4p6a8Ags9HT7x/a0KsJZnsYL1iRPF/3vWyou9W/yHLxg7Uw08O6+srpmMjafEqKW8hfCVcfEV4NJM7noq70PaNAmn9c2NgmUx5DbuQp6Brw3b2srjU/6E9l0jeIZSFb/RJYULQfEmclAg3+jhvVj+Y1ASFzGCCXlIEGrE9ite9AuprVuEpnqaBr4QgCIzzYtsYkRjbWGsr0a4SiJQf6AFnKXVDfJxdSKUjl48j9UjUGYGGfm7N/ECXm6TnIpmeyORfWg6STiGDfWTQk20CwXbZ9vqvTwfaENlbLd6Day5/s3zZWRXU8HH/ggi6q3VOdBRm8wqBajRZedBsIZrjp6Mz3oxPsh/CMXzvcWNlSQLe58Gcj0Tw07HHYOg+tqVT3m+GMoZGUMEJt6u/mZIWDqf6XnhmJ/4gy0sdW9C8RRRRUfQR02WiV9CA9f2pxIzTq6UFvNrTIOuJYVEZFJurdN6a3YVzG0Gls0GjcqZl2KY81sUbFhj4U467p6A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB1327.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35079989-07ca-43f5-fbb4-08da54e62004
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 07:00:58.2442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EKaHRhiF1sKBDjlQ7Lxd3HN7QZknzUp5JImI45tz2G/lpB0Hq13FC8sUoTOAj0ICVHeDGy09EjLiRdll6xMquw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3505
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Christoph Hellwig <hch@lst.de>
> Sent: Wednesday, June 22, 2022 10:44 PM
> To: Dexuan Cui <decui@microsoft.com>
>  ...
> On Wed, Jun 22, 2022 at 12:14:24PM -0700, Dexuan Cui wrote:
> > The third parameter of dma_set_encrypted() is a size in bytes rather th=
an
> > the number of pages.
> >
> > Fixes: 4d0564785bb0 ("dma-direct: factor out dma_set_{de,en}crypted
> helpers")
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
>=20
> see:
>=20
> commit 4a37f3dd9a83186cb88d44808ab35b78375082c9 (tag:
> dma-mapping-5.19-2022-05-25)
> Author: Robin Murphy <robin.murphy@arm.com>
> Date:   Fri May 20 18:10:13 2022 +0100
>=20
>     dma-direct: don't over-decrypt memory

It looks like commit 4a37f3dd9a831 fixed a different issue?

Here my patch is for the latest mainline:

In dma_direct_alloc()'s error handling path, we pass 'size' to dma_set_encr=
ypted():
  out_encrypt_pages:
	  if (dma_set_encrypted(dev, page_address(page), size))

However, in dma_direct_free(), we pass ' 1 << page_order ' to dma_set_encry=
pted().
I think the ' 1 << page_order' is incorrect and it should be 'size' as well=
?

Thanks,
-- Dexuan

