Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055456288E8
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Nov 2022 20:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbiKNTJa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Nov 2022 14:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiKNTJ3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Nov 2022 14:09:29 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11022014.outbound.protection.outlook.com [52.101.53.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE9CF015;
        Mon, 14 Nov 2022 11:09:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXvPt/uvfRlbeUXB1s00HSR/4Lu/xyu86kRHAH37d9Bv85/NTjIio2aml6kLbrgV4v7UCB8FUfWBmlIICXBcU24MIhjTo6uOtcJTIc7Gphi5L8LY/BoFwK9nSyJtH/vcJ5inXL3jqMgY3OTsnnwtmhkSbpdIGufpzPm3doxScf8UAwXnWD4PPtEpOkmP8gaJIYJeBEQTTQfDOeFgS7H9MJ8QVRItqS4WwEeS94OGoqONUBmE2W1d2D93lM3PhvrQEgOHwdgrzdRgG0t8Fw14jzqKIQdMa+8/y6VyYkJJlrb8M9ImmlX6l53MKDFWWE7HIO0pA2UNrsSvE56Dftv3Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OS/dmSfrA6WXU33/S62sddWZ6fOZtfL036Rai0Vb1K4=;
 b=cjSPhqQaD+SsZwmYMLeCc6xSoTSQR/pfokWjgT9bpw+skl72QYwurqD+BV3J3SUgjt1ysdXIInz+RFT8Va4LpJf09R+oWVXrOlHPff8D4SHQAxRVY6sxzSJr2ccRhwzNuF3pU/RgNH41SF+HpOkfjK0ZltD7oZURAyZW1fOZdEDuaEuOMa5LZp1D76A5fxrFR0Zu64aY5wG0EHmRNAqsjKEYga9rpgwMHH0vOZc0nc3IDUn9S5qS20KISqvL88E8msJe85+VkQcp4+/QaRlUgAwxixM8CU3MSFoehVMxFGVEg5eeKzNfY9BBd/mvOjTGnX/pNLjm1IMftz53wDpqeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OS/dmSfrA6WXU33/S62sddWZ6fOZtfL036Rai0Vb1K4=;
 b=hdn+/nCk+pBZFv4ycQ5FFO0MOtak5sxPfyYNHvUMsMh9bFCA12jyDio3B0EJLU8XBqCPf+hqPd8qxWqo/0EMnCThBU+HIyCrrcUnQoYpZC4n/W9gEey7MXzqSC7yWNXXyapPBT5EPRds5MikQLTGUCh6f5HFRANmjkwa3xYrXlI=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH0PR21MB1941.namprd21.prod.outlook.com (2603:10b6:510:14::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.6; Mon, 14 Nov
 2022 19:09:24 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::6468:9200:b217:b5b7]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::6468:9200:b217:b5b7%3]) with mapi id 15.20.5834.006; Mon, 14 Nov 2022
 19:09:24 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH] iommu/hyper-v: Allow hyperv irq remapping without x2apic
Thread-Topic: [PATCH] iommu/hyper-v: Allow hyperv irq remapping without x2apic
Thread-Index: AQHY9G6MTvL64VjEeUSlJ0XIa/5zY6457YUAgAAElfCAAAq9AIAAB60AgABTl4CABCGJgIAAVIUw
Date:   Mon, 14 Nov 2022 19:09:24 +0000
Message-ID: <BYAPR21MB1688FA95BE87E9D1B607B050D7059@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1668020853-23950-1-git-send-email-nunodasneves@linux.microsoft.com>
 <Y255HhDbwbI/z5bJ@liuwe-devbox-debian-v2>
 <BYAPR21MB1688800D35F86D766567C1FAD7009@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y26F+H1SuJrad3Ra@liuwe-devbox-debian-v2>
 <BYAPR21MB168819214A20DF2E4835E763D7009@BYAPR21MB1688.namprd21.prod.outlook.com>
 <2f721208-d169-2baa-fa1f-b8450e80ddd7@linux.microsoft.com>
 <Y3JJpyvCcrRZfJkV@liuwe-devbox-debian-v2>
In-Reply-To: <Y3JJpyvCcrRZfJkV@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6ebfefb6-228c-4d0d-9e05-c7f3aa561bd7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-14T19:01:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH0PR21MB1941:EE_
x-ms-office365-filtering-correlation-id: 02086794-20ba-4faf-3e03-08dac673be9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ufTxW8wtTlRfDtGn+ibkfq3PZg5ZQC9I4Gwjd88Xz6I2szyXC1JI6ZdHoQXSg2luw7rrw0XhBemv9Ile7frhw68KGnEWKILqCTakl0QIdQ0r2cp8qUTwrvjiTbPGcSdl4gPxmSU6Gw/3gH7ar89mXa4r7DvEWHF2J4yqETCcjx2pRMscmHdnOBRDVR/Hz1eU7l2vKX6C5doe1UpvCaZ+C+ha4JkwR3L41H2k7x4STEYdRZ28rPLQIREJzwSrSkKART7Y9pp94JO8FvcUVhROUqsMsoSVv0l/2MBsqKjN4sDB//Q4Hi8pwBJkxoVXrPmSepDiXc6tlMrNoTY63DJZCqy0UuCJctYmVzH3Of4tMdx4D4/l3hjQPlYblgudmjaSjWPliCiqpHcJ3t72bcb+0s0xW2Hr4cxEF9kBk0nWrGEVkM/oq8Wfw1Ju5dHnv29ZF7p1ZMrbW0Z8T/RRn/piIntBD3QoMeCRqgERGSZuiKJlbSZ5XOV8Hdffh6WG9sfusT10EFcYEvfX5J0Dk1JdqtryMlyLVy9hlSzJtwqzVeAkn9bfTcYw7Z7lKCDdOn86I7ODA8FzuULQfQF/Zs7yR3lRmFgVKw2J7hncu+sv3EQNwiJJAbHvg8SYtPug+dEwP3tfhoQ9oUl35cA+/ECB2bTvNtnbTeyoRJei8viRpxWKk+Xz+68QlKEnJIq37H2dIFuArNNAuyicwD12yqI5c9/VyNCFaLwWEhEjOLlVGdOXDmIk65tmEWHH+KftXGg/MCC26+QIjuXjAhp/2GHnpbUjvLMxSr7NFDtF22F5SXen4HqaxicR5NGnrS9ivNSV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199015)(186003)(8990500004)(55016003)(10290500003)(2906002)(26005)(33656002)(53546011)(71200400001)(6506007)(83380400001)(9686003)(52536014)(8936002)(7696005)(86362001)(5660300002)(478600001)(316002)(66946007)(38070700005)(64756008)(8676002)(66556008)(66446008)(4326008)(76116006)(110136005)(38100700002)(66476007)(54906003)(122000001)(82960400001)(82950400001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d/z5eFBo0Jdcd3nMMnTgoBehj0BVOMXrY+6YvMpVvjww2QtdszFct1Y325/f?=
 =?us-ascii?Q?x8ai2V9SGeDTZv4OVi3WpUcyGg2AXpd+LN3ijsVNpaua+o+OXKVwqPdZ9gF0?=
 =?us-ascii?Q?38AE9Kw/K20Cee+arFBWf21rZgCw9QSmJrR1+a0yGIqt1QbaxutFlonNxtmq?=
 =?us-ascii?Q?QLXXb4IzEg9DUefoC98ucUzfyZY4p13dEi2ah8RFJoB9XPYB7MOYO0/7LidD?=
 =?us-ascii?Q?GZC/vg2YZGbAQoUdnHk8Zu9i6ruunZGIHeeE9Rmx80Ov6eqxOR3HXFS0NWD8?=
 =?us-ascii?Q?hBmZEMPOgINQyEHp7ppyu2HXRcF+p4AnjxtZmKsxefm7dbrzkZ3m0grUWVpN?=
 =?us-ascii?Q?2l+i7H9LFwVFxWcn31y3WLQLvoghGaeVjZjWojIZklJgHNYcLOcMCbBqfIn0?=
 =?us-ascii?Q?oIavdsLuvtcCLsW62TPMh9/06JTuhiyNYdr3LgB7z4O1HRGqiFMefBCLikEn?=
 =?us-ascii?Q?tr7SeK5E00wW0HjzxtRCjkqFaY1/YQ4XZ/m5vX3F9RwF8jP+HK1J2ICyuNZ7?=
 =?us-ascii?Q?zViblM47civV7iqI2yUTnIJ7rX1S2Ff5VO5Dklnw+xuZ8/nLY41jT51KFgvi?=
 =?us-ascii?Q?VutOC4xYWaMv/7aub/Mt3atbZ7PW8gdoXglhdSlZVx2mAGICda6Koi4elT0K?=
 =?us-ascii?Q?3pEvk8yawOYUjE++TA/OHEiLdr2hCBCwRLvV9nKvWL7E5g3Jdt6rQfk6sOq7?=
 =?us-ascii?Q?vKzPwG4e/AXVi2heuZK0qXN7GSCDxIA4//kWJcOzhPid6TfHsUeaHn7F7gBf?=
 =?us-ascii?Q?oW3WAfjm6ucUHMlvf2FKGHlLK46FUmr/1IGvJ3f6TdYUXOe06PfJo+dHa3X1?=
 =?us-ascii?Q?ItrR/hX0J1W6qMkinjucpiiv3fDdlR2xj2MurQBMsmw5iUSGsQ6Zhk6fYZhg?=
 =?us-ascii?Q?orlIWq+teHGJ5uP5iLHV5tRFuECEhssn0Takp1Ab5PE0jhykyumhQ+hpyMmo?=
 =?us-ascii?Q?HZjOzIMxVMNmg3ODUbhR7+YvLjURfK6wk8EN/zgdwLczJwWJTyrpKkQ9xzJ6?=
 =?us-ascii?Q?ShqHFEaTYgupJb79bjeHF0+Vqe1qVAezygVXEf1HHqudyN4NehhB7YG44QIv?=
 =?us-ascii?Q?6A0pqoJy0g62hHv60Vsqa6/Wfn2wW6gQ4jSiv6A41TEGe2EB17XDAjnw/HD0?=
 =?us-ascii?Q?8dFmnuwMA6QhNs780IqQvw1pECW0FOlq07ENZq1SzXeKy4ww8F09pC+E0kvR?=
 =?us-ascii?Q?X5FQRiCI707WVBRB5+v025Mh9h0dyZrhRzCHIiLtms29m5aNaPlXgCodfczm?=
 =?us-ascii?Q?xBQu7dis5mfzn9xSX6vQLlabEOGi5v+SjLt31w+9I4xFOxmFccSHcsO3qRIE?=
 =?us-ascii?Q?0lerMk7jr7BbIKzDNL206K4mUZmXh3G4HnauSLU0rFCzXSTEOa1vi2+51Qxv?=
 =?us-ascii?Q?12Sk1TV6EN+IlFbmwX/y+6wntYKZVUoBtQMcLE9Jd/YfWAUGVTbwGkouFKXQ?=
 =?us-ascii?Q?zhEuyuqv7jp7W0Rw2ZAJfp/qQGIQq/yz/y5EoRsPcjkF0KeshP6hKt/c1wLk?=
 =?us-ascii?Q?CAw4su6uZz7hq6mYX+gHujyRuNAhWGPKEbZVBEc3QUP8TlhSrY9zmO+7A8+a?=
 =?us-ascii?Q?O8iJIJsgXPJm+ol8YWSY/xi3UfLRRmH2ejW/YeMdDlcJq3pLZopsQB/tvzKh?=
 =?us-ascii?Q?Lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02086794-20ba-4faf-3e03-08dac673be9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 19:09:24.7352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cBlhR+G9zr9lqJDSZASH/wFYSEPOAPbNYipNXV/Ti4mdab5lVn3lqOKzZjLW3AJ1nPGQlpDzsIc/FMNerS05tdwks0t9IaJH5dEmbaFgUN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1941
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Monday, November 14, 2022 5:59 AM
>=20
> On Fri, Nov 11, 2022 at 02:53:59PM -0800, Nuno Das Neves wrote:
> > On 11/11/2022 9:58 AM, Michael Kelley (LINUX) wrote:
> > > From: Wei Liu <wei.liu@kernel.org> Sent: Friday, November 11, 2022 9:=
27 AM
> [...]
> >
> > I've tested this patch on these Azure SKUs:
> > - Standard_D2S_v2 (intel xapic)
> > - Standard_D4ds_v4 (intel xapic)
> > - Standard_D4ds_v5 (intel x2apic)
> > - Standard_D4ads_v5 (amd xapic)
> >
> > I've tested with linux Dom0 (nested hyperv root partition) and as a
> > regular L1 guest.
> >
>=20
> Okay. I think your tests are good.
>=20
> Michael, do you have any further concern?
>=20

If ms_hyperv_msi_ext_dest_id() returns "true", then
hyperv_prepare_irq_remapping() will still return -ENODEV and you
won't get interrupt remapping because it isn't needed, at least not
for guest VMs.  Is that what we want for the root partition?  Or does
ms_hyperv_msi_ext_dest_id() only return true in a guest partition,
and not in the root partition?  See commit d981059e13ff.

Michael
