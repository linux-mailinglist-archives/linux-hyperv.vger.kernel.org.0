Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91783D7B64
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jul 2021 18:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhG0QvZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 27 Jul 2021 12:51:25 -0400
Received: from mail-bn8nam12on2105.outbound.protection.outlook.com ([40.107.237.105]:38913
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229494AbhG0QvY (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 27 Jul 2021 12:51:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNofY+MGXbdgrtEc9bMgsWJtuYK42H/RNlxDG8Mz38nLAQjbz8QmVPyiLZTMItU3hY1H2tSAMmE0sw6cbZ+HtC0lMt2njK2b+qHjfGb9oVOpSLnZaRDb3x16HMbqhcNa9NUgETvADxJ6lACTwTfSAmXqD/0E+RJIdBIgHURlegdsvysIIipJYklE0SuBVYnD/TxSpQy2BHrfUxAy469sRT98F6s2jgFlMGXwGaJr7gewT8Q2GBNN7E9WioW/IRJxZgImbO/NCakHBNRBMNPSgYV0hTm6bBVlYfKR13oCIi56SgsTOgZ1hcMw2YGESnw1w4lxbMIXROSFgre4GVPqDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiXO/ZeqDzhVNOXyadFuIZ5WfRSZEdatsflYQfuHj9M=;
 b=jHYC3maxBsF8FIC9baW0KBHuAgOxhEJPslrJ9RkNZcnp9ndUDMi0hworGRtI4MygP1A5x38VjglYI7/75pvPgbZq8n4WIIWPpUZABKdF8JI43AITbmmxzsmsdTmqgDsODOqLo79y+rCyX9imCqoT0oNfTOzwyWYX2uX1djuLK/eUKSFUMQH+uMysOkDImvb8/pphNI1csA9Rt6Vy3K5xAqyGThnGlWJjRlzZnOBxZLZOEt03IPhXBXbFNVTeCZMYuiaRFiWxFFo9Oz1xu6mlhaMtgklQOicwnFNswIhgEHXE9MYQXCyQbDQi2bgRyiRsRo/qvbysvcq6XdRz3Fx50Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiXO/ZeqDzhVNOXyadFuIZ5WfRSZEdatsflYQfuHj9M=;
 b=KOL8M91EcwILM2A3xkJ//yH26l2rGa7erzIfGOLhwhmVVHOGqKQ6zRfLU5SkalNC7g00j/yzrLCIWw/GFbS599uhIojdI4fuMOKNaqoEpRVs3ha/YZ90uB5NfAr1tlmuA4v0jYtLchloYKtdRDDKoFrkfsVfsP/bFqmKlRg7xRM=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MW4PR21MB2074.namprd21.prod.outlook.com (2603:10b6:303:121::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.2; Tue, 27 Jul
 2021 16:51:23 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::292a:eeea:ee64:3f51]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::292a:eeea:ee64:3f51%4]) with mapi id 15.20.4394.005; Tue, 27 Jul 2021
 16:51:23 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "viremana@linux.microsoft.com" <viremana@linux.microsoft.com>,
        "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>
Subject: RE: [PATCH v3] hyperv: root partition faults writing to VP ASSIST MSR
 PAGE
Thread-Topic: [PATCH v3] hyperv: root partition faults writing to VP ASSIST
 MSR PAGE
Thread-Index: AQHXgtPz/n7CxiZ6zUi9GbDbsi36lqtXBSEAgAADfKA=
Date:   Tue, 27 Jul 2021 16:51:23 +0000
Message-ID: <MW4PR21MB2002964FBB69F00BBEE9F324C0E99@MW4PR21MB2002.namprd21.prod.outlook.com>
References: <20210727104044.28078-1-kumarpraveen@linux.microsoft.com>
 <MWHPR21MB1593C1A51C6E812B0DA82ED5D7E99@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB1593C1A51C6E812B0DA82ED5D7E99@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bbb7c5d6-6379-42c3-a4ab-d20d2ffa5317;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-27T16:17:48Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a85b7ce8-55ab-49e1-0d73-08d9511ec43f
x-ms-traffictypediagnostic: MW4PR21MB2074:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB207403F27408FA824C4B66F2C0E99@MW4PR21MB2074.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S8AiY19z/Mmj0aQkZxtZQSSJ6CvkaR+Om+EfnIn9j/8pNg6xaV/vM1WlG5qt6/8vKW4TNZziTXNGiGN/n/9ZEVjKf+G9lyJlI9Zyh3Gbt1Rx2DwZEvkbo10Rofh2BakeOTZx9XRoaINWQaBh0pTxvT5c+hWkvgiXtG49IJffJOfHjVP8CO7dkwqg22KIrIkmdX3Z/iLnxP+r5nOfVhaK/IHqEG+jKQC8jbl7jgEk5Yo2GpG+2I/shMwtiLjubxwBAPUOS9xvyE9C0Y8fp/vt2ygk0qZrIYen5aw7QLo9uNwQnCX8klsol3xkXblAWxMVomBFekGo0Dyrd9kMtiLAyL/MWVjewS2gha2aym1O68+uYuZru39ZRGs50mPPyaTa3DoX1yNF+wd+m5DTgFsp0E9EiaMLwhd0pzBralLYOAeRuMGhLFQSUgzjiryL4Hfp2mlUWYa+CNDvBRzI/LNSBnyyzK9D0lLD3sdf92UhDmPb4k0VDryOJQVeGfKYmzmHVGbG8mhIiL3jyaKO6ZCDf2W9RrS7qQv7Payd/BPiF6bCDQykv11HoUOe4GNl2zQ+8SncNxylU+DoLlPixmp57kOxoNM97iEbk+wmmFMQWHwCkzKBnDgOLL05CZcBXl2OdharEcu9HjrQaubQCa3190d0/rvm57kghq/3Ddq8HrJ5UKAIaNAyOnX3T+XKimisqTyNmQhBh6H4oS2pstlDng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(33656002)(64756008)(66556008)(76116006)(2906002)(66446008)(8936002)(82950400001)(82960400001)(10290500003)(54906003)(7696005)(5660300002)(110136005)(316002)(52536014)(86362001)(508600001)(4326008)(66476007)(4744005)(107886003)(186003)(55016002)(8990500004)(38100700002)(122000001)(66946007)(9686003)(8676002)(6506007)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0qSn8YOBJC13QYlFlxntNFAkj62qtb0iqX74VEjeye+aLprQ6BQkgsaQPJ/d?=
 =?us-ascii?Q?3vCRzszVJw4fN4tGeksUWri159ih9sXYHppZDWI30otkdYE2578omaA/w1OF?=
 =?us-ascii?Q?siaThVUQoW8kNVQg24msh879Bjn3nMqBpSxdEddGLd+CCxS31k7T3zcfsWl/?=
 =?us-ascii?Q?DcSpJIYap9xQO/V5LWUSmCbMAlJ4OOJDVV6YKGLz22ERP+xZXl4bQz7b9YLi?=
 =?us-ascii?Q?diYaIE2ySVEVh269gpjETg0QUWzUsDg0EXulcxhDE2eX0IiCH7TXRLOYpM7l?=
 =?us-ascii?Q?g10q4Wf5c7DhI23YnWNsu+e64vkiZBeJFxMVbGeKwQTda2Cjdi6j1Ex6FaP1?=
 =?us-ascii?Q?YSo2DMGP+Cso4+xuUHd3gDxX2aDKRzfaXPcS1Eem3gpyEQ0hiqdaxcGuPokg?=
 =?us-ascii?Q?qBAPHk7Kv+qn77KFiwiXcCc7UPJSWjXQhmaE/HRS6YYWN3tMtmFo45yvQSnj?=
 =?us-ascii?Q?XtGFIjGwKphkOLYE2AuLyCehAs6MxXRH02FzWhjZuKkzuJxoqmKeNtTPh7l9?=
 =?us-ascii?Q?MTV5+1GdpFtcn0vrs4su/NkRTPxhVC3b/9Hq85nLS91eCd8jcX60gUcB8BNq?=
 =?us-ascii?Q?xNAXhaQXMu4odseLliRKPkzXGHxDVPXmHV7nMaDRCX2weDYeUHTpRrEqrqSD?=
 =?us-ascii?Q?WBcLycq4UyPiR8Gc4+GFAS967szHAMrpb6B9aJmpw5hQlygZHi7PnTv6aV3n?=
 =?us-ascii?Q?n/d6n8NgbZM/YLS+ocwwcnyNx2DchL+4VOcwKCbVsCpc7Cy+3Fg0LWomFMUW?=
 =?us-ascii?Q?M+E5uATi+b1dgBuaFntFLUDEw9I78Nvo1Lxq+mu2hn/FDaGNWOg5fh4vcQ/u?=
 =?us-ascii?Q?616rBe4OKgHQj3QS2dbXx5QnHdp3UNAbTZg2tT6Ggsoyb+uLxxQRekvP7/Li?=
 =?us-ascii?Q?A6hq0NbgW+h5PkxlZUb9hkqf/PFg2y+FdePAQAl8U3mTJfM+DRnThrrTq9sG?=
 =?us-ascii?Q?VW61ZSjLW8kr4n9dsy4eVN+zvr6uBDkquPYfBrzTQlOOcM/+tO/86xF+NIvU?=
 =?us-ascii?Q?XB3MQ2OR2Bo1LpLjkgDcikWbJ7faXt2WGbxrJbc468OARrFDNsz8a3c/4+3o?=
 =?us-ascii?Q?P+fbhFz5K/23nLPuNl3qe+SvezKLlGvcGXiBTIoSiTkax/Kxg/8GzHddEwSQ?=
 =?us-ascii?Q?S7Dq97y0FO3Svv7ICvtRrzIDFUeyULVICZltPioLYX8GxH6/mw4IRNlj5zGc?=
 =?us-ascii?Q?JVJNijZa2b3PwTDjPRnc19rOlnDt+rktH7l1OAUfOvZLuOtboWB3u+gDks7/?=
 =?us-ascii?Q?0LWX/DlgzylMs6NYCcaWNMcGf7iHjA3So2MCK5kKTUjQTzhmUhKVnFXR3I8K?=
 =?us-ascii?Q?u4BsTtJwVQVS20UmD+eiksjOASTdzO+XbR85GW0jd0Z9lHurKiRM7kuA33lq?=
 =?us-ascii?Q?MaFEhk0IF8z9rUzM0JHJB6NdDKXg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a85b7ce8-55ab-49e1-0d73-08d9511ec43f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 16:51:23.1557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5YQkzwKfDtILNgTXjZaf5kLcg9FoRPMDwbBxQZI1VmSDqhb3QuAmCBM/CIxZK4a5YEA2DkbpDtBWSXns2dgqCUITwoxWBLmNGBx8c2MGfbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2074
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> >
> > -	if (*hvp) {
> > -		u64 val;
> > +	WARN_ON(!(*hvp));
> >
> > -		val =3D vmalloc_to_pfn(*hvp);
> > -		val =3D (val << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) |
> > -			HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;
> > +	if (*hvp) {
> > +		if (!hv_root_partition)
> > +			msr.guest_physical_address =3D vmalloc_to_pfn(*hvp);
> >
> > -		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, val);
> > +		msr.enable =3D 1;
> > +		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
>=20
> This version has a substantive difference compared with previous versions
> in that the "enable" bit is being set and written back to the MSR even wh=
en
> running in the root partition.  Is that intentional?

Yes, the hypervisor won't allow the root to change the page address. So, to
enable/disable it, the page address needs to be preserved and just the enab=
le
bit needs to be toggled.

- Sunil
