Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 881E9B42E2
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Sep 2019 23:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387869AbfIPVTO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 Sep 2019 17:19:14 -0400
Received: from mail-eopbgr680119.outbound.protection.outlook.com ([40.107.68.119]:22599
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387825AbfIPVTN (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 Sep 2019 17:19:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3E0r3S46gA/0DQiuai3N+4/WK6QP+H2szrVUx0hqecJj74nlQ54JGFqWNc2I3T3G9V7rZQ8ke1MnaiMXYHrSrfYrifo5kx8Kt0aoMYHuq+UK5zLFBm7+1EtO7A1ewojgpYfWA+EditIhGUpnGdABGwAS/9USAF4jIwYpVcA3+uZVKUvzKr0rjEGm4F15xfQpYEeY6AiH+NR++pnJZ/lcJiymF8PRBYIUA1HwjoEbo/8vRdI0ue/XNyYAdSuwq5pG+uCYbgWq7NZxnAi/wQeGViG10IMjVOVSGVmBqe49Wall5pgOLh4UdEY5lstzOqBkpzV/FrCpGfnNJmlBDsXRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBkIH2sCMLDhsm87o3O2Iza/8/fo4JBesVzF8XXU72M=;
 b=bzaWPjs+zMWNsr783YuMQ6YsLZG3hOzaub2OQ6nOanI0rl5AaJTem21WMSOa/4HFT1VZPQ4v745d5xSr2kCqOx1SW9uDxccwIg0nhOKPHRubvTXuNxw+bntgkor2TnLfoYfoRaDK6APFgiS99wR8Dyknqanfqj9cG/3l3sudwW5lWQnwUMrKDhqZc2l7G/deUXBOnnn8atOxM1RNQzeV+4QdJT69URH6opWzOYhIgZIbCwjUmTqCHucV8paPlu2syiudy/k2VD7WV1rso4nygAgqIDINUoU20vBc5E6udSXQniV1TakRxk+Bxcms/37cP8qq7KiZ6rwN+A8rFCG4SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBkIH2sCMLDhsm87o3O2Iza/8/fo4JBesVzF8XXU72M=;
 b=PqUhJoOjRcNjg99QWv/d7Na5irouCrtP5fbUeaFmESL6LxG0tNSLvm+k41dSC5QkIcj36k7tOA63tc+8826oa5/7hKYju5jZik5GC+mgAz4Ea1u1fSYcWLlAOonUgsR0m5sOaA35iCHq+dJy6z/oC3SO4kCUdUEgoMU36Sm/Lc0=
Received: from DM6PR21MB1337.namprd21.prod.outlook.com (20.179.53.80) by
 DM6PR21MB1451.namprd21.prod.outlook.com (20.180.23.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.10; Mon, 16 Sep 2019 21:19:09 +0000
Received: from DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::2cde:35d7:e09a:5639]) by DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::2cde:35d7:e09a:5639%6]) with mapi id 15.20.2263.005; Mon, 16 Sep 2019
 21:19:09 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Denis Efremov <efremov@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: RE: [PATCH v3 02/26] PCI: hv: Use PCI_STD_NUM_BARS
Thread-Topic: [PATCH v3 02/26] PCI: hv: Use PCI_STD_NUM_BARS
Thread-Index: AQHVbM9rTh2Y2PUhrEqo6UXJiPJtiacuzuKA
Date:   Mon, 16 Sep 2019 21:19:08 +0000
Message-ID: <DM6PR21MB1337B733B179578DAEA555DFCA8C0@DM6PR21MB1337.namprd21.prod.outlook.com>
References: <20190916204158.6889-1-efremov@linux.com>
 <20190916204158.6889-3-efremov@linux.com>
In-Reply-To: <20190916204158.6889-3-efremov@linux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-16T21:19:07.7862893Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8230eaa9-5501-49ca-8f5c-b5c6c7145f5d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 552841b3-1635-489f-fe8a-08d73aeb8349
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR21MB1451;
x-ms-traffictypediagnostic: DM6PR21MB1451:|DM6PR21MB1451:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR21MB1451F797BAFEDA038459198CCA8C0@DM6PR21MB1451.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(13464003)(189003)(199004)(110136005)(10290500003)(102836004)(53546011)(446003)(14454004)(66946007)(316002)(486006)(7736002)(66476007)(66556008)(64756008)(478600001)(476003)(4326008)(25786009)(6506007)(6246003)(186003)(26005)(86362001)(11346002)(8990500004)(66446008)(76116006)(33656002)(10090500001)(74316002)(5660300002)(6116002)(3846002)(6436002)(99286004)(52536014)(256004)(53936002)(2906002)(8676002)(229853002)(7696005)(76176011)(81156014)(8936002)(9686003)(66066001)(305945005)(22452003)(55016002)(71190400001)(71200400001)(81166006)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1451;H:DM6PR21MB1337.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 26r7DxL73h4QMx3BKKHeRTK6QSj9Au8ddcTyk9RMcdmZ3i6z+8BhP9B3p6X4E7eLEXt6gOGkneJfK5WT4XD9mq76Bdla45LLCqMChxzdvNFBhOvq9Cjsftaqijjb6KHxPKG+x75fXkJitBrYlJK3kHz3k8NLVyzsFja3ov3688eUgV29HYfqnbFv4mBeLEjEJrThKECwjn54AqSEZpNFkGHE4/WLjdnQBGs//HeOCaFoJ/Ls01yxTGnZT0LvaCSbqAqqs22/Y0eHW9v/b3D8fA57ArL8mZLyAqoppOId592XQdMkRrjCrcN0WCNZUvb48nZAN5h6OoJqOfvV6InlroxgyBpHcCkjjLA/FQZsU2hY62cSOSElLw5XO8dEdToOOuMZ8P3o5B9fYHOh+XyXoBJW0klN4YoT67Tz6cOa4pE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552841b3-1635-489f-fe8a-08d73aeb8349
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 21:19:08.8932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qdp/FCbcOSuvErRbTNUxyeqgufub3MAno+ZeNEQMpaHqSTe+XDjlvsxv9pT9DiyEfzLeijCUEFFeiK/gJF+6vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1451
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Denis Efremov <efremov@linux.com>
> Sent: Monday, September 16, 2019 4:42 PM
> To: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Denis Efremov <efremov@linux.com>; linux-kernel@vger.kernel.org;
> linux-pci@vger.kernel.org; Andrew Murray <andrew.murray@arm.com>;
> linux-hyperv@vger.kernel.org; KY Srinivasan <kys@microsoft.com>; Haiyang
> Zhang <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; Sasha Levin <sashal@kernel.org>
> Subject: [PATCH v3 02/26] PCI: hv: Use PCI_STD_NUM_BARS
>=20
> Replace the magic constant (6) with define PCI_STD_NUM_BARS
> representing the number of PCI BARs.
>=20
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-
> hyperv.c
> index 40b625458afa..1665c23b649f 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -307,7 +307,7 @@ struct pci_bus_relations {  struct
> pci_q_res_req_response {
>  	struct vmpacket_descriptor hdr;
>  	s32 status;			/* negative values are failures */
> -	u32 probed_bar[6];
> +	u32 probed_bar[PCI_STD_NUM_BARS];
>  } __packed;
>=20
>  struct pci_set_power {
> @@ -503,7 +503,7 @@ struct hv_pci_dev {
>  	 * What would be observed if one wrote 0xFFFFFFFF to a BAR and
> then
>  	 * read it back, for each of the BAR offsets within config space.
>  	 */
> -	u32 probed_bar[6];
> +	u32 probed_bar[PCI_STD_NUM_BARS];
>  };
>=20
>  struct hv_pci_compl {
> @@ -1327,7 +1327,7 @@ static void survey_child_resources(struct
> hv_pcibus_device *hbus)
>  	 * so it's sufficient to just add them up without tracking alignment.
>  	 */
>  	list_for_each_entry(hpdev, &hbus->children, list_entry) {
> -		for (i =3D 0; i < 6; i++) {
> +		for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
>  			if (hpdev->probed_bar[i] &
> PCI_BASE_ADDRESS_SPACE_IO)
>  				dev_err(&hbus->hdev->device,
>  					"There's an I/O BAR in this list!\n");
> @@ -1401,7 +1401,7 @@ static void prepopulate_bars(struct
> hv_pcibus_device *hbus)
>  	/* Pick addresses for the BARs. */
>  	do {
>  		list_for_each_entry(hpdev, &hbus->children, list_entry) {
> -			for (i =3D 0; i < 6; i++) {
> +			for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
>  				bar_val =3D hpdev->probed_bar[i];
>  				if (bar_val =3D=3D 0)
>  					continue;
> @@ -1558,7 +1558,7 @@ static void q_resource_requirements(void
> *context, struct pci_response *resp,
>  			"query resource requirements failed: %x\n",
>  			resp->status);
>  	} else {
> -		for (i =3D 0; i < 6; i++) {
> +		for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
>  			completion->hpdev->probed_bar[i] =3D
>  				q_res_req->probed_bar[i];
>  		}

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Thanks.
