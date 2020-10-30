Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920A72A0B16
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Oct 2020 17:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgJ3Q3Z (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 30 Oct 2020 12:29:25 -0400
Received: from mail-bn8nam08on2122.outbound.protection.outlook.com ([40.107.100.122]:35608
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725844AbgJ3Q3Y (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 30 Oct 2020 12:29:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGlXkxEBUjMqA9S04DxDVfD9+bhNQM8zAa7tjwXwn/UzfyQNAh0dF7yHNDUk/+Ae9IlbulI9oWZqmLM4jLVGBFoNBh0TXoQzTHN0VaklTQNXlgRrBwFK+3MH93TX9f3kKkqqTns6ZrbvXcS2wYp0O9LoFBKd6tTHSwsJIomp1cDpHTTgTySqgNqjpJ+UJOk+wX6doibzOpjYr6HK3dzryHJSpkGDPXkl4EI4xJvLl28k5pDSKosvWfXsq9Xt59xq+014rc8C+J+L00J6BoOqktJaqbmiCDzKs07wffXDKzjBlhceRDX97AVOJOwSJujFwjOwOHsMVzIk8/insohwKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eftVsvfuIED5evtTpmld1bfrKmOpa1g6efsGnZb4ac=;
 b=W3tyZgOpkyLhXPwcz6v6Um0hcKkfqLVX/D7qjs8GW+LteAGWdxq2SnzQ6pRWTjAAYD1+EpR/7DWW7qLJayCMOqwahwBcl48Y0mBIWQCzD2UiliQUif3p47p8rKQvBWnOaJwAcJqzcGwA6XWUJixLKW2m8AHWC6lvYT3NDxJJoEzgwbVsG2W45LsNzkMRESL08j1OhG6NPI6A3dTx1hwXBl+zkB9vChoKnn4hHWENJI84zNAWHBTasDII5USe2K2HWZh7y+Q+IT6zOAFc+wERIuNcpaCpB62ayae4j/6aoKAqDYdo18aGau++CmECoofIe3oyC9/c4WGZnIZUdFHZvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eftVsvfuIED5evtTpmld1bfrKmOpa1g6efsGnZb4ac=;
 b=fqjfq6IoRYhUy34Z+N5mE+8AwqXp8VgkwOXL5+3y1H9DB+VbLjzfJ1d2ebkspksDFEJRjBQSq+vUl9NlqqTp61YpOER2ScIIxVv8fWEFrakC3CPgiC2uGwB61B41jJ2kvFxvkPsO3DXxMJu85Qe0JuYlk/X0r3AjryBCJTj/3K8=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW4PR21MB1860.namprd21.prod.outlook.com (2603:10b6:303:7a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.5; Fri, 30 Oct
 2020 16:29:21 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::101a:aefa:25a3:709c]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::101a:aefa:25a3:709c%9]) with mapi id 15.20.3499.027; Fri, 30 Oct 2020
 16:29:20 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>, Wei Liu <wei.liu@kernel.org>
CC:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Subject: RE: Field names inside ms_hyperv_info
Thread-Topic: Field names inside ms_hyperv_info
Thread-Index: AQHWrTt9rFNF3ELO4E6cpSBQfdrxj6mwRwAAgAAQkoA=
Date:   Fri, 30 Oct 2020 16:29:20 +0000
Message-ID: <MW2PR2101MB10520A20D4ADB1CE6B6AD559D7150@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201028150323.tz5wamibt42dgx7f@liuwe-devbox-debian-v2>
 <87lffnzqhp.fsf@vitty.brq.redhat.com>
In-Reply-To: <87lffnzqhp.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-10-30T16:29:19Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=99976526-55b8-4d9f-808d-0734651a10cb;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 47b2a2cb-b0fe-4701-b2ad-08d87cf0f48e
x-ms-traffictypediagnostic: MW4PR21MB1860:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB1860F7BCFEA4C9B1853A954CD7150@MW4PR21MB1860.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XgW7t/4mOZK1Moziu/PyGzgfm6oTz02TO1z2nqfKInYbJSg2juTby7shTuxiOohTI0OBLX0DuMR6aAcNJLLPosGLrNhKrJQqBsjGUzupyUvYcgB7MvSJa/PEKg+LnhAo260xuaQOP2XOtE8oXlZQDFGMBtkUuTnQ8qR+TFO74XTdBJoN4i/ryIhJR2VH69R0buz/NIKWsqrwcvdyptIiYuFSdVqpqpqKrf7x4+GGFheZwxs8jPISBVy2FSIQmtx/sVETY560eBiHfC3urbC6ZEYc60MGEmo5/mgmkdaqmiL08nBDMZifsot3KgytFEvS7xOeVwdMWJu9QnBsHIhYEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(8676002)(26005)(186003)(7696005)(82950400001)(82960400001)(4326008)(110136005)(10290500003)(8990500004)(33656002)(2906002)(6506007)(8936002)(86362001)(5660300002)(316002)(83380400001)(66946007)(66556008)(66446008)(66476007)(64756008)(55016002)(478600001)(9686003)(71200400001)(76116006)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: kUi40P4xmKVr1xf61Vg1cgachr7Fb3b5o0vn8jvoG1DbcNS7vQr3IwEVFJecw8OhtnEEdJEGS/wd9v+gh81rCouRW2bopTWfKe8nhyMxK1rEs0DZnerxUU8VuJHiVVE0RssL8sHS9YmKdgCCpG/+i625E8aHoF2DRmUavV6bOfNtXrTtPtl5IT1cS2sxCaoxzBGJ0rq2/wHlbehQ18bCq7r6OlCN/NTyQA1vDI0PSoPhsJG96JOfy2DIiMsbEZ6F4b4fy5zihGUBgeT5/n9t8cC/QeCxuODVzNzYra508tRjj+uKnl6Msr9XLUMBq/UJFkDanErcpnew9kkj45G7iQli5eNNye7mkm12cww3kUrKRyVmNy0GNcZnj6y8WfjCeUFGps9maQJdDPh9iQyhSGr5DHc7SPaRwpE3OM4sKK9AaxQOG7wQBF3i6iCqb08ZNiX/lPTP/TVp8OnyeYn5hDCevEqTEKMECk/6pRXvk4A5oXVXHC5r9qiVjabGW+itRK49Qo0SXSlVemfDtNNJq03KjH+tKPnL42byfuNk2Joy7dT3pDC+8/mRZX+1BzvKwIisKq2x2MKCyRZV2nUvITfP/FvtwpBrta81XdjajIvUtNPd2+b1cl5qCBF5sh0DxvYFNMHXRvKglCPt2cn8Vg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b2a2cb-b0fe-4701-b2ad-08d87cf0f48e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 16:29:20.9163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fo88yvxzzXBB/76lox1q3tPOP6lrm74127HzTQOFW3P25nsuJVkAwIEmD0SUE6UQbTvPMY1BPQJJc0zX+gatmMv7Ch1eDBEOW1I3DewJhaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1860
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>
>=20
> Wei Liu <wei.liu@kernel.org> writes:
>=20
> > Hi all
> >
> > During my work to make Linux boot as root partition on MSHV, I found ou=
t
> > that a privilege mask was not collected in ms_hyperv_info.
> >
> > Looking at the code, the field names of ms_hyperv_info are not
> > consistent with the names defined in TLFS. That makes it difficult to
> > choose a name for the field that stores the privilege mask.
> >
> > I've got a local patch to make the existing fields closer to TLFS. The
> > suffix "_a" means the value comes from EAX.
> >
> > Given that this structure is also used on ARM, so having x86 suffix is
> > probably not the best idea. Do people care?
> >
> > diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyp=
erv.h
> > index c57799684170..913af5e93cce 100644
> > --- a/include/asm-generic/mshyperv.h
> > +++ b/include/asm-generic/mshyperv.h
> > @@ -26,9 +26,9 @@
> >  #include <asm/hyperv-tlfs.h>
> >
> >  struct ms_hyperv_info {
> > -       u32 features;
> > -       u32 misc_features;
> > -       u32 hints;
> > +       u32 features_a;
> > +       u32 features_d;
> > +       u32 recommendations;
> >         u32 nested_features;
> >         u32 max_vp_index;
> >         u32 max_lp_index;
> >
> > Any comment on this? I'm normally bad at naming things so any suggestio=
n
> > is welcomed.
>=20
> My take: let's avoid ambiguous '_a', '_d' and use full register names,
> it's only three letters after all. Let's also avoid suffix-less names as
> eventually we'll need to add non-eax parts. That is:
>=20
>        u32 features_eax;
>        u32 features_edx;
>        u32 recommendations_eax;
>        u32 nested_features_eax;
> ...
>=20
> I would also feel comfortable with these names sortened,
>=20
>        u32 feat_eax;
>        u32 feat_edx;
>        u32 recomm_eax;
>        u32 nested_feat_eax;
> ...
>=20

This is in the asm-generic portion of mshyperv.h, so it is shared
across the x86 and ARM64 architectures.  So I don't think we
want x86 register names.  On ARM64, the eax/ebx/ecx/edx
portions are retrieved all together in a single 128-bit register
read.  I abstracted this into four 32-bit parts labeled
"a", "b", "c", and "d" with the obvious mapping to
eax/ebx/ecx/edx on the x86 side, but without using those names.

We don't have a TLFS for ARM64 (should be coming soon).  Might
be worth seeing what naming, if any, will be used there.

Michael
