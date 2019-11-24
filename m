Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A057B108548
	for <lists+linux-hyperv@lfdr.de>; Sun, 24 Nov 2019 23:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKXWVt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 24 Nov 2019 17:21:49 -0500
Received: from mail-eopbgr740104.outbound.protection.outlook.com ([40.107.74.104]:59802
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726855AbfKXWVs (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 24 Nov 2019 17:21:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzyKTCm+tKbXjygPJgv52/PYfIZfhdJsTQoaF/zZLXBWeQVD4xQP7qQCgZMM33FAb37igWRztx/5Ds3W7ZPVSNkrqE7wGi1OYZa68cRNZH03qULZNSSmVeB1YIgwzRtjra5RgMMV7bTHc3/gcDNf/bqsPEk0g5zjelG0h0leaYVeeX+/F3A3AaaVY8a2iYs3fv3IPZNvSEfLH8RM9aQlF6jkw/Ns07ExNkDDTzcAw2u09kP2wzIN2a+5IlwbtQASwNl9HDwk7HWwT+ZFTvtn/orkp0hGRdMnWEewlBUndJdqt1yshnJBeZyZ8HN7177KE4nYalmDE2JD6Y4TggrfHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDY4E4rILYxinoj+gZarkGbVgR6fRD8ukMONwSS7e9A=;
 b=CY9pDKwIx8DYmb+RuTYXChvSDdBLOBqsww4VCMtdaCPLQMQOhGb3Iclw0tC6t2xwN+I4c0tupD1BpZzQw8OuU/tn0BCxceuAE7rNkoLg0bs3XwEXSzFjfNaKN+VXxnIbuZPvMlmC57REyS252fd9hV1DORXLIuceqZzGJXFmsCMgzp9S5JNPjW4AuJEixhRyWErwV+B5Wt1hc21ABZggj3JSLnpm+Ao8E9WWhB8y+V+Qypd8pNNPTjMehriagnD5VJ+vo/iAzK7z5GGvLxzOm2IUju1tUJ+ipvAl4tDXdLCyRSxZ7p2qdVM7/lNAV9A4IDHoJhN3awKq1UUuGCGzjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDY4E4rILYxinoj+gZarkGbVgR6fRD8ukMONwSS7e9A=;
 b=aCbYObC6DiE/x6DIraiCBE+DnmQXChb1WwHP8YecQizulrxBQEl2e8u4jecnLPxPMuznvqVo2revu6VkHUZ4cgbp64mMPlUKwcMf8QxKJ3qpqk9rY0s6NvWh/1vZR47Z9iCOFjffoRFzMnsFjpVeDL3Gb1GnU5fwFHLzBkCiJnU=
Received: from CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) by
 CY4PR21MB0504.namprd21.prod.outlook.com (10.172.122.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.3; Sun, 24 Nov 2019 22:21:06 +0000
Received: from CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c]) by CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c%4]) with mapi id 15.20.2516.000; Sun, 24 Nov 2019
 22:21:06 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: RE: [PATCH v2 1/4] PCI: hv: Reorganize the code in preparation of
 hibernation
Thread-Topic: [PATCH v2 1/4] PCI: hv: Reorganize the code in preparation of
 hibernation
Thread-Index: AQHVn3KKmzvzrqG4R0iXeL48d2bs8aea68AQ
Date:   Sun, 24 Nov 2019 22:21:06 +0000
Message-ID: <CY4PR21MB062982456B34D2937AF7E7FCD74B0@CY4PR21MB0629.namprd21.prod.outlook.com>
References: <1574234218-49195-1-git-send-email-decui@microsoft.com>
 <1574234218-49195-2-git-send-email-decui@microsoft.com>
In-Reply-To: <1574234218-49195-2-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-11-24T22:21:04.1569298Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=99f785f4-fdd8-4f18-b472-91e2d974b6c6;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 87abeb3c-4615-4438-4aa6-08d7712c999e
x-ms-traffictypediagnostic: CY4PR21MB0504:|CY4PR21MB0504:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB050482F2CD347EA4A3BB30FBD74B0@CY4PR21MB0504.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 02318D10FB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(39860400002)(376002)(396003)(189003)(199004)(186003)(76176011)(6506007)(8990500004)(1511001)(52536014)(55016002)(66946007)(102836004)(9686003)(64756008)(71190400001)(25786009)(305945005)(71200400001)(2501003)(66066001)(8936002)(4744005)(256004)(7736002)(74316002)(26005)(110136005)(33656002)(6436002)(86362001)(99286004)(2201001)(446003)(66446008)(6116002)(3846002)(5660300002)(81166006)(10090500001)(11346002)(229853002)(2906002)(7696005)(6246003)(478600001)(10290500003)(8676002)(66556008)(14454004)(76116006)(6636002)(22452003)(66476007)(81156014)(316002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0504;H:CY4PR21MB0629.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?76N7r5COZ20Wod4AwJwwUnvCZrN8ETe0/dr0mRAVo0174CCT0YAtOt0QROy7?=
 =?us-ascii?Q?R5tfCkUqXhHlC5sI4ywgu9j2LZNnt6F3IrFw98fBXFJXnpcwaWQfLoMAY7n8?=
 =?us-ascii?Q?qlFOsjvX5V2jRXwVhXpoJJEcExN0acnZquZ2/Z/w9d7CRQ5KAhyqBB53CrXd?=
 =?us-ascii?Q?MlPTaux59XILB2voBu12237iUOrXLTkj+3ixwXiPHhMvxbfCzvLCi1k5nzLy?=
 =?us-ascii?Q?nf6IshVV6RurfRvQ6Md+q83bdOtE+qFLK55itD7Ya1MNkb29BjG9DG1HdvYU?=
 =?us-ascii?Q?79ys+0PrhzJVfMLGATI4q5NANwydFbt7V8phru7nw4fPpyAGng91RCFHgSrX?=
 =?us-ascii?Q?oUBcfxAzhl2M7UYUkDUsHRAkKLz32ZwwnGNaN2N8YACfIreA74zIIGa26EWm?=
 =?us-ascii?Q?IpkLM+6RWeD79tw+Ff0c1ilAfqx/kpfC/X4iL8g7Qw0OAIw5m5oQ3Utlqen4?=
 =?us-ascii?Q?9HepMRSH+EExCZjPwZprCSPd9285wN538u/3Ipy6oUqZT5OWvnwUZNbOuuof?=
 =?us-ascii?Q?PcJ5vtgM5XyF/FACzmJtuuzkBCqKrpwNTePIzZdf4YBri/U5cype9CTmX+6j?=
 =?us-ascii?Q?7hzeTwhQPbiV4bqZdNVXgunTu3mv7dGVIPRper7RBSsMtN8zsPn/J6FYvoP1?=
 =?us-ascii?Q?of51IJ+LBJ5laoW/jNw3+6GQUj3OueeECfYesPnDpuSca1mzjX2srY6FRa0Q?=
 =?us-ascii?Q?LvES57DDVTOfhwY62xjPD6zo+8XOfJz5IfV+JSHOS4gB9knGJHpYOM2lbWNa?=
 =?us-ascii?Q?Y5A5gYL/DMGip8LoM9Aemz/eAUtbSaKr+vs3rRDypt+JwyOCQIRyiBXc+hmt?=
 =?us-ascii?Q?sAkZJPh0hWkn4LOQWRSV7I+q8LDmeDen+BkvztEcCTdr5YDrbTH/I+RcY0/C?=
 =?us-ascii?Q?8PlTaReYb7Sgax7xndQ+XQU0JPgCOM6ZsOrtjiIyvHAi+pyoT/i+7d43UGjT?=
 =?us-ascii?Q?tvAO00Tl7P2lNFO+ekHrZQiN21RsmAZlNoBVNs4tTYOFrTzTpmBxl/FOHwOo?=
 =?us-ascii?Q?2620lKbSES7Oe7avNWyEaBZLD632K3x7mOe4mg3Qymiplnsmx/ztEuxK2oKJ?=
 =?us-ascii?Q?ADN4uk766Ujpo7/DazJZz7CpmxaonUcs25G0cmI1tg0asKhUH+eYzU+BFlu1?=
 =?us-ascii?Q?LWPoJKN5CjAi6x43zDhKoNsMO8rx1EyNlveGIllGPDtyncWxxNO8/oBqTRC0?=
 =?us-ascii?Q?EmBBtQrWLHBn7NVd7ugALEI9W46uzggW7fr6KSTIM8Ba62ysZYbfIP7g1UIE?=
 =?us-ascii?Q?nqLUOIfC/Dtb9A46Jvkbbcm5J/JF0nS+qJwcd7ZCW4595bpSStxjveeNVbaH?=
 =?us-ascii?Q?7k76KxMGAq1g4oJ6GFdt87JaPn3+BYLPgTYZh1AXfn+O11W2Mief5C8trSdK?=
 =?us-ascii?Q?6ZFAF6sQU6B3Uv2RF/I0UJDL7Cv+Y2lc8GeiJ3piLaYFXBRl4Kw39bz8O9KP?=
 =?us-ascii?Q?CB3KVmMoHSYrWgHys4Nby31a1Te/iGObQpEczYXsDo+54wKkHPsaVeLYNxRL?=
 =?us-ascii?Q?7AUXouHlSHX+DA2XEhrivIQzj8KLgNQpe2ZV8rssVKkWfEvfebiEDIZOfORv?=
 =?us-ascii?Q?+KPJ8zTG6MrD+RNtmLLXlQGd4q/dPRlIKdO+t1/Dm8rL64YrF9pEj/YMwn6g?=
 =?us-ascii?Q?xocSNthDwlW0RxIRe4M1M8z9T1875evn/BhO5lWf3DvZXJ4PBSL89zwNjlVv?=
 =?us-ascii?Q?Jhx00FXeeT6NLu3EwzNAPeYDmrSsuTDi/NphkvLrNbuAyhNX371jgHWTrQ+5?=
 =?us-ascii?Q?MdtAyWTp4ishXB+VFfv8SvaAGSdcjtZUWA3Xz0upZWhshGopBC8EnJvpK9nN?=
 =?us-ascii?Q?Ee6L+7VKX3h2dfS6BJDIkO9ONiuPpVtBQMYkiqAdg/79uBONZKPZGNgqLgBp?=
 =?us-ascii?Q?2ZJmK/zvYUWVIdwETTb0P0QfDdmaJXNIZlha7xYU3gXRGuaR6go+l5SOUAs6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87abeb3c-4615-4438-4aa6-08d7712c999e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2019 22:21:06.5202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V7ztDlLu31Q9o8QAmbPX8u0IbxqhU9Rddluuu5BiALYvDvsc4uUygrxPd0zbQUUvmzDL/LnhGKkwrVf203Q5p+4Sfjhynk/228QbJ3UWwtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0504
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Tuesday, November 19, 2019 11:=
17 PM
>=20
> There is no functional change. This is just preparatory to a later
> patch which adds the hibernation support for the pci-hyperv driver.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> No change in v2.
>=20
>  drivers/pci/controller/pci-hyperv.c | 43 +++++++++++++++++++----------
>  1 file changed, 28 insertions(+), 15 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
