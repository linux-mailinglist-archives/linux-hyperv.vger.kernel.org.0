Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06542140F0B
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jan 2020 17:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgAQQfT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Jan 2020 11:35:19 -0500
Received: from mail-eopbgr1300110.outbound.protection.outlook.com ([40.107.130.110]:31983
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726915AbgAQQfQ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Jan 2020 11:35:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KO1pVVMBaVbLoPL8GqcZ8htQcHoMPmALUCs8yi4X0gMinSK03f488wuuZMzjhzCHM8bMiL66/K+3ZYvneGX3gPbfMhsRdVI4g1OSbYyZQYUXz6F8Au9ZbEQ9+7ielMJ495+1UCGPqggMpCU2z0f2JeWEFvgA36FIGloakiPXQn+ksWdhGf4l337bnN5YCID7cIRI4qMOo17ytur1wxRoh1FtH3oYzdVOtQqobZkmxzYRkWYcNKeJORuzTEvqHFnSpUnXRyPWAqbICh3qD2fOJaBMZqhRMxunkNiRHrM7XfZnNzyX0zb7QwwzgxqQR34l2anYZ78d4/CHKIEUGpV5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TIxwAa2rj8eHSL+16z/GBn9LvAeGT1rPTpig2II3gI=;
 b=R2RaEM15OX4NVLv+Lbm1a+7PUiPfEXHmJTpZXFLaMZuo2DEo2Rn6YwgNgHzFOWTKljpH1N0b+WivPGPjdapDXNJPgngeLDLGBBnDqFgk21pl24D51iWMwMf3j/Ny8Y7+5SFuj4qv7ORQuw9CBArTc2Rwh36I/vgN6tprCUyD/My+PnHKRIZrkEqoi27+AziLyabbTB8EvOLcCvgDApPEPyMA5FNRKVytXLBA5qc2Btvty8NrtiqQGABgBnQBzxABvJy7+xaWqaGm8wyfxsNO+5VOsix23BoaKlJWghUmQP8ssX1BmqodpnuPQGPSirvKWsDwUW7gLdNZc5Ga1Lh+kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TIxwAa2rj8eHSL+16z/GBn9LvAeGT1rPTpig2II3gI=;
 b=VAIqJO1CPpJU6X1uSZG5L7emmW9uuiMWFbT6acvHWzSVJPtnYXd1oQjqYofhEop56AVwhnJyQrU2Wyph5iH6paTL5dN30tMMdGRO/X2YB+W8JzE2czZm8cWaNwRJvj/kpLNZ19IO+njCcAvC4Byoks4nPIH9nkxlvgEQDQvYJs4=
Received: from SG2P153MB0349.APCP153.PROD.OUTLOOK.COM (52.132.233.84) by
 SG2P153MB0125.APCP153.PROD.OUTLOOK.COM (10.170.140.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.1; Fri, 17 Jan 2020 16:35:04 +0000
Received: from SG2P153MB0349.APCP153.PROD.OUTLOOK.COM
 ([fe80::e8e6:3ff5:1354:c16c]) by SG2P153MB0349.APCP153.PROD.OUTLOOK.COM
 ([fe80::e8e6:3ff5:1354:c16c%5]) with mapi id 15.20.2665.006; Fri, 17 Jan 2020
 16:35:04 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     David Hildenbrand <david@redhat.com>,
        "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        vkuznets <vkuznets@redhat.com>,
        "eric.devolder@oracle.com" <eric.devolder@oracle.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "osalvador@suse.de" <osalvador@suse.de>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>
Subject: RE: [EXTERNAL] Re: [RFC PATCH V2 2/10] mm: expose
 is_mem_section_removable() symbol
Thread-Topic: [EXTERNAL] Re: [RFC PATCH V2 2/10] mm: expose
 is_mem_section_removable() symbol
Thread-Index: AQHVxV94OmmoHHYtiky82H1ysWWO7qfj7JsAgAS1vtCAAVMkgIADb8/Q
Date:   Fri, 17 Jan 2020 16:35:03 +0000
Message-ID: <PS1P15301MB034764C1FFA3D2711DAED14C92360@PS1P15301MB0347.APCP153.PROD.OUTLOOK.COM>
References: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
 <20200107130950.2983-3-Tianyu.Lan@microsoft.com>
 <20200107133623.GJ32178@dhcp22.suse.cz>
 <99a6db0c-6d73-d982-58b3-7a0172748ae4@redhat.com>
 <SG2P153MB0349F85FB0C1C02F55391F6D92350@SG2P153MB0349.APCP153.PROD.OUTLOOK.COM>
 <20200114095057.GK19428@dhcp22.suse.cz>
In-Reply-To: <20200114095057.GK19428@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-17T16:35:05.904Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [112.65.62.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fb1da60f-fe0a-4848-8e73-08d79b6b34a2
x-ms-traffictypediagnostic: SG2P153MB0125:|SG2P153MB0125:|SG2P153MB0125:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SG2P153MB01251E64A114B92C493643AB92310@SG2P153MB0125.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(199004)(189003)(4326008)(316002)(52536014)(76116006)(186003)(53546011)(478600001)(6916009)(6506007)(33656002)(66446008)(8990500004)(86362001)(5660300002)(26005)(8936002)(6512007)(66946007)(2906002)(54906003)(9686003)(7416002)(81156014)(8676002)(81166006)(71200400001)(6486002)(10290500003)(64756008)(66476007)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P153MB0125;H:SG2P153MB0349.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4IfotzIuPL4vmoCQskvv2w2hdZIUoUpFemzB8MHIarBzn8hQRHRy6j3smoITiZSxaeIP9IOUpl4d9IYmyMLDZiaHXoJCF1F2XyJrJeZPRNpkjIy4wsFyk3miYqH9Ev5fbyWKWoCPuZOn+85H7/7a3RPdHW8cC/Fe2ihCGbS16VWMuKFJvCVBAs9nGHZ/ekLuI1Q9CLM7r7lfNFZaXFLA3O1imHm0LzEphjVtXB02TTd/1bO2u1Kp8tldeTEweY3KHNzp+i8e1yGoZfP9ymiJHTh03omuGJx5/I8LG05uy6Cqe1jmnHxOe1+sRGGLm881bFH6G+GwBwcrpP1dBPxQT+UNIOxXQu5tb3YCN9hNR7BQWiibmErIvtmMylcwPxgr33pYp8XqOxep9i/q45T+wh7+MOySxLitelIEAttQnRhuNYpizkOr0fAbPTjwJheS
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1da60f-fe0a-4848-8e73-08d79b6b34a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 16:35:03.7842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SrxTPGShP+xzRCylPuiETS3POTQICEtvNA7/JixQLnRk2cfOv8aci36ml0W40JY4gVivYD9ixQOrcbNVvZVw1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P153MB0125
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michal Hocko <mhocko@kernel.org>=0A=
> Sent: Tuesday, January 14, 2020 5:51 PM=0A=
> To: Tianyu Lan <Tianyu.Lan@microsoft.com>=0A=
> Cc: David Hildenbrand <david@redhat.com>; lantianyu1986@gmail.com; KY=0A=
> Srinivasan <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>;=
=0A=
> Stephen Hemminger <sthemmin@microsoft.com>; sashal@kernel.org;=0A=
> akpm@linux-foundation.org; Michael Kelley <mikelley@microsoft.com>; linux=
-=0A=
> hyperv@vger.kernel.org; linux-kernel@vger.kernel.org; linux-mm@kvack.org;=
=0A=
> vkuznets <vkuznets@redhat.com>; eric.devolder@oracle.com; vbabka@suse.cz;=
=0A=
> osalvador@suse.de; Pasha Tatashin <Pavel.Tatashin@microsoft.com>;=0A=
> rppt@linux.ibm.com=0A=
> Subject: Re: [EXTERNAL] Re: [RFC PATCH V2 2/10] mm: expose=0A=
> is_mem_section_removable() symbol=0A=
> =0A=
> On Mon 13-01-20 14:49:38, Tianyu Lan wrote:=0A=
> > Hi David & Michal:=0A=
> > 	Thanks for your review. Some memory blocks are not suitable for hot-=
=0A=
> plug.=0A=
> > If not check memory block's removable, offline_pages() will report=0A=
> > some failure error e.g, "failed due to memory holes" and  "failure to=
=0A=
> > isolate range". I think the check maybe added into=0A=
> > offline_and_remove_memory()? This may help to not create/expose a new=
=0A=
> interface to do such check in module.=0A=
> =0A=
> Why is a log message a problem in the first place. The operation has fail=
ed=0A=
> afterall. Does the driver try to offline an arbitrary memory?=0A=
=0A=
Yes.=0A=
=0A=
> Could you describe your usecase in more details please?=0A=
=0A=
Hyper-V sends hot-remove request message which just contains requested=0A=
page number but not provide detail range. So Hyper-V driver needs to search=
=0A=
suitable memory block in system memory to return back to host if there is n=
o=0A=
memory hot-add before. So I used the is_mem_section_removable() do such che=
ck.=0A=
=0A=
=0A=
