Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B715B306136
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Jan 2021 17:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhA0Qow (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 27 Jan 2021 11:44:52 -0500
Received: from mail-bn7nam10on2118.outbound.protection.outlook.com ([40.107.92.118]:29728
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231646AbhA0Qoi (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 27 Jan 2021 11:44:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAt7eGd3Qsvq42zmm8ZZmhdMmIrgCqHPKplDkW/bhxIjilKzjfCqYWei5hpp6EAkPbBdlkXFsMo77Xd4KVDytgLwBvMtQPrSQW6xATiU3XT2P1/okC+3cKlkzblX33i2xzkIuU9lJ9pvTFAvoXIcBM69gDJfu4x9omnHshgbXHQg/hixo2gQ8QZ5fkT2/UgBqdJtbJLTft43wJruw/my6xK/bmhuANZ2QL+t9sw8o6/g3KNXYzHrGV4PRswV2vP9z35xSJcgSQtN3KUaBpH/kiFkG6JRrduUlYflcRMIpC64b9lI1s5kOU744IjxBK2uvSlzd4P75WRxQqhoH6SRRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=189edLwrESBPgwJcssyWz3hfzzqy8l/mP0c7ldKlJCI=;
 b=P6V9LJI9lStpMY5pDWw2fM+pVmzkt19xO4UVNGNOhi11afFblbmOAMgi612udKDzDAP9CLUHA3z/wX+RSyIHD/3hePfslj96DIG+N2O/G87l1jCrlMFZ6S5AOMxr4n0MB5rZiD7/Uk3O6VkopD4YDBiDNycyAii9JvyRVaVIWvTR9FKZfSXqrfhyz0+L/vBybGYI4dSMyKVnAzXZKcMU2lnU5VGx6axnozzsm0XYTXmiHPSpKI9CWZ4M28HAh3Y7Yf972mx8KAw4aONhX+MuHj3Xle4sQjzFh4lHZZ4kqJO472hqUiKerO6j8IaAoZQS+fzgdh+3T/twEQfNOxMF7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=189edLwrESBPgwJcssyWz3hfzzqy8l/mP0c7ldKlJCI=;
 b=G6Ky4EUFkRguAgKNbrCnXjufZcdzdih0cDgk3qi/+wrCcC4/rZ2i3EzD3Ae7eSpTWYOxerH0BwrVzR1Xw4wn/UWpLATKo7QABGusjDhnN2IIKrdRkrrUoduNUciuJ46D1YPvFClMrnCeKIQ9jBpp6Zj76WyBKmxqM4IabW8NY6Q=
Received: from (2603:10b6:301:7c::11) by
 MW2PR2101MB1769.namprd21.prod.outlook.com (2603:10b6:302:2::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.4; Wed, 27 Jan
 2021 16:43:48 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3825.003; Wed, 27 Jan 2021
 16:43:48 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH] PCI: hv: Fix typo
Thread-Topic: [PATCH] PCI: hv: Fix typo
Thread-Index: AQHW9J9SRPX3wU6mtkOy6PdWvbDQAqo7rb+g
Date:   Wed, 27 Jan 2021 16:43:48 +0000
Message-ID: <MWHPR21MB15930123D3EF0E8C4C0D8E20D7BB9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210126213855.2923461-1-helgaas@kernel.org>
In-Reply-To: <20210126213855.2923461-1-helgaas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-27T16:43:46Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9bdcdc21-0bdc-45c2-b2b7-ad62eb13cee1;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [66.75.126.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 22da55ca-3083-4e04-e2c1-08d8c2e2b88c
x-ms-traffictypediagnostic: MW2PR2101MB1769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB176950946ACBE267F5A4DF6AD7BB9@MW2PR2101MB1769.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a9eLCfJEejrN5lculdAbzJxJv/AsJAgMQ9kMB4lWjtL74LHizYUiQV1RTeNYxCItwO7Nr+jW7R8l/YJ9UhtkKR4mU8BF7ZTBYBxClkgg9R/GSFA7ds3RCxo1FqSW32uLF2I3JC2cfbvy3zrhIbPwbNWBkAw+E+52gK4v8HVEdjZtheeDFiKQ9fa1z88pSdGN4wl2h4bbFYhr7i8V54YbttGCR7FEaCdJBWOhoIBHOqWPoFMY2vn472jERJcCwg2wjQMf0ZT32k33+/Gp5xH/eGAkfwJX+4PHx2pcHjEdHkrI42boxgfrwzszv2Y8vo0nGTIWN8bw4OaudxlW1349CJplz3x6P5FnIgeKN1MhITWwUnAJfM0UJ0kK9D7KJCI0P+d3cfR/12UHQOrzv1yJ1Q5JczG2AtRgBAAwaxxY2YBu27dNJGI0eUw+rgI/eXkCfpJYW2du4ond0FspAWStZLuJfLjFkDB9bnv46bFjehyU2FFrXv08azj+WfzE4xJbOz7UNam8u4EPd7STVX0BWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(55016002)(2906002)(6506007)(83380400001)(82960400001)(5660300002)(9686003)(26005)(316002)(52536014)(86362001)(7696005)(54906003)(82950400001)(186003)(4744005)(76116006)(33656002)(8936002)(66446008)(4326008)(71200400001)(66946007)(478600001)(8990500004)(8676002)(66556008)(66476007)(64756008)(10290500003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?raLwfM9UvOrsyLwwcIvIIRWJ4GrhOEbRk6KnG5jm1cIHxAaCpvek7foRwZ7g?=
 =?us-ascii?Q?Cmwb7GJZhbooyW/QukDWX1YfEnpf/zq+JzA5m92qhm+B26Kx4X75Hb5iIkAX?=
 =?us-ascii?Q?vlJANAPJ+WbDq938EIoURWcFrKySJZ3fZ0jy+yjrSiKtI8oLn6903zAr4/q1?=
 =?us-ascii?Q?EliITyCLkv6xGsgM92OSpeBsEZeRYIRW1bYAno6GxpR0iHEOpLpDZUqUXOYD?=
 =?us-ascii?Q?WuTgubI3aWPYnbWWFdInKe1mnWueX945BPckwme0UhvoZRQH3+Z5pvDHDPPC?=
 =?us-ascii?Q?5pZDZ9SdBcDOt0+0CuV1pB69mJ+JAPjVxLXMB2AM42eh8wm/SwvXtrKF6ZHw?=
 =?us-ascii?Q?jTcggfLGAJnWFCOhoGp3z1PD0kxdPCidBZlANzFjkzhu8H91POj6csKaB2Dq?=
 =?us-ascii?Q?FfKk3CyR3QMlAfXhEmaCOI14e6urGxYqSjuCujiYVGyj2h2xgCAWdkbtum8b?=
 =?us-ascii?Q?1QoRf+qza9jurzLbuN8l+9+IZp4sTf+hTgncwSBueAbxXUJlVb1sexvJLjpx?=
 =?us-ascii?Q?GwuEWMcnwuUh4ld2F60b6RmLUsYIvk/qwpGctHWjJcev8kXE1Ony04IjX0NV?=
 =?us-ascii?Q?waYdrn1zAfLThEa/RtdjDY2MhP31YggECSta+Q3lnsqPshviCAQISBccHqZu?=
 =?us-ascii?Q?tChTzmcqut+vOR5v65y/OpVd2NUt63GTYHzWej6EeBpM6GOU67WbPYvXikYt?=
 =?us-ascii?Q?z4yDXlZhAwuGsEbsj28/AkZBOnz7S7gsT5LtzivATWpA/yJPV7GTAiQbHuX1?=
 =?us-ascii?Q?SnDYLoDfQYyzPE/JtuLWkeXNuyZy3k6lDZkz8i5A+P1jiBWRf/a0fiR3G3iW?=
 =?us-ascii?Q?zFYO2zBY3GFN12WdQy/2G1Jd46NbKJK5UV1QA0qtPNPRTpdrNT5tko+5RpqU?=
 =?us-ascii?Q?vrYp4HAKKrwfihnCvg2KgDX9tmSej+vYyclfyMCmyxFWs6E3D3/qAOqrWB11?=
 =?us-ascii?Q?TL4DpoRE4fuMflRBE+Q1NF1qZNkKtJQbE6dWOWDcv6wA8VMszn4O+J5osb+C?=
 =?us-ascii?Q?tXFdZaKKQY+64YuUDXIfrnveMtZTF+lbK9x5Tai26UAZKjHNvuBoHTqb+t46?=
 =?us-ascii?Q?e9vvdrk/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22da55ca-3083-4e04-e2c1-08d8c2e2b88c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 16:43:48.5644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TO0l6k0yv6rjxUI5aFV1lW5iPXvDfjiAicsmChCuWZ8CRyacegMuw2VuYkPup+SzRxffHEx65ymt3pl194ZKltt8yalHgKsosMmqSr4HUNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1769
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Bjorn Helgaas <helgaas@kernel.org> Sent: Tuesday, January 26, 2021 1:=
39 PM
>=20
> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> Fix misspelling of "silently".
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 6db8d96a78eb..da0c22eb4315 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1714,7 +1714,7 @@ static void prepopulate_bars(struct hv_pcibus_devic=
e *hbus)
>  	 * resumed and suspended again: see hibernation_snapshot() and
>  	 * hibernation_platform_enter().
>  	 *
> -	 * If the memory enable bit is already set, Hyper-V sliently ignores
> +	 * If the memory enable bit is already set, Hyper-V silently ignores
>  	 * the below BAR updates, and the related PCI device driver can not
>  	 * work, because reading from the device register(s) always returns
>  	 * 0xFFFFFFFF.
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

