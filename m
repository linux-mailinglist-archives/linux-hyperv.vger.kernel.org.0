Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27A33033E7
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Jan 2021 06:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbhAZFIW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 26 Jan 2021 00:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732011AbhAZBl4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Jan 2021 20:41:56 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20720.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::720])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5C7C061354;
        Mon, 25 Jan 2021 16:39:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tj240ytOeAftgzAHtv277rk0rcPaXGxycX1ljRF0Ggp/knEsXq0guusgMnS5h2bsva2W6p0+W9VkO6ejo9uaZXbdEzeAsAaWU0pAF5z+BUvga2WDbf1aFWlRby3ef4mdA2Nhk9qSZxfxCdAffauTt+N6zZEZShtLa5v3e4t9vayYzHbyBbCm7y35qSSK8JZ3rnCl9VM5zdmMhVudKuWhh5y+TQ7vOVxRrWqGuAoPepxOSIFuecVGEd9AD9b+Gfbp/arzLA9rWvoDEGUSGU/Vr/vRZ+FSwnupRHQfVL0Hjo3eDVl+b9SWh2mReSOJeEi3j2FlDMRUvV/E9vnEMnJI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFED4gD4RHSpyUuZ0qI1HjioY9Uk7X/CocCy1zD0VSs=;
 b=fCShE5TVlca75eE/EOnENMbcdzJidIPVBCop8NK40yrh50WZpdP27T86d4+xFE1a4YKTbV+QebWqWxmBeyGCPrduIsRfK/1EyiO87FFL6ypkFKH31vSL6jB4Yu0FePsyminL+h6/iw9EorfY5uSxtuhsIp0fr2vUQXErPYLZt8PIOehQ1ilFEpz1QrW7gY0S8aON+Gi/VwcHwFG1xkZ9jsnf6rci2k7+/HCqwlJpuK0hgk33QLrvZuXY9HYclYd0Azwr5g5wEyDfFljw2SUWlPQJd7jEmpw5zd7bkgolsHZanF4CBmLz5gWhYa3hqSSrgjn+L01Dgn71K1n6LuxDPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFED4gD4RHSpyUuZ0qI1HjioY9Uk7X/CocCy1zD0VSs=;
 b=OQMC+xqPkYdqUVS/1vxkBjeOBgfb53Fv3NMD4AqQp6DA15vPkgm9AT7/+oWsHC1bO5pgyDD+kfnijnzOyazmJnyYVFDQJs+4kuIQ7e23AVp97No7BELmxmclurwQyZcaP19Jd8nOBbM03XqoiM0B3fErSK9BngDgM/fDFWKhpP0=
Received: from (2603:10b6:301:7c::11) by
 MWHPR21MB0862.namprd21.prod.outlook.com (2603:10b6:300:77::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.1; Tue, 26 Jan 2021 00:32:37 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3825.003; Tue, 26 Jan 2021
 00:32:36 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: RE: [PATCH v5 03/16] Drivers: hv: vmbus: skip VMBus initialization if
 Linux is root
Thread-Topic: [PATCH v5 03/16] Drivers: hv: vmbus: skip VMBus initialization
 if Linux is root
Thread-Index: AQHW7yPwbHRjbrp+3062gSh4P5hdm6o5FvSg
Date:   Tue, 26 Jan 2021 00:32:36 +0000
Message-ID: <MWHPR21MB1593BE5FD96AF79193D6EAC9D7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-4-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-4-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-26T00:32:34Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2394a8b3-a653-4d5d-a69b-2e425496b817;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [66.75.126.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4e8ac8eb-9759-4d37-8a7c-08d8c191e171
x-ms-traffictypediagnostic: MWHPR21MB0862:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB0862193EAC7905E36C5E6F40D7BC9@MWHPR21MB0862.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ezcfOIJ37E1WvJAj9xhleKldHOjhx1ox4sLCTzFHNVNwMqv8F0d9moPhgxVpaHZ25pxYWZOn8aEc0Ix6Eba8Ybp++qeQ9xvaKhswFyqf2/X4SrcsQPhX3TpCuoDZvUnF6WDGVacL9sAZq3wmgBb40ZUePpqWrxzElVMLWt0WW+3A//VysKhNKpd0cohJ7mZII6wAwb+oHo2NXCOoqqJEIBs1OLg8gNUYTzj1ts6h5AZ9p65V8CVTzkG2hvjrhMg3ZwE3ZPX1cGqOqGEO8d2a05G/Qt+jtTL4npEPA8K8SflTgHC53FIk36Xhs+jn7M81e8iq4e7TebRQgzGZNkvZmer45Edcq71ffQJa4S3RIQmRjv5fa6vhFoZHAIiRczCheQo3zDxm/Nd6lh10CJM0D/eojQwA662qJfmxAsop/8K9aN9agQiYYAUA5FinKA+nzJ5c5VcPyut0Et5heSLB+eTznIVE+uqexSkePtXylkWWoAba+//FWP4qkW6OLq6vq3JL41O6NEINanjXwx8uWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(7696005)(66556008)(76116006)(8936002)(9686003)(8676002)(66946007)(86362001)(66446008)(64756008)(82960400001)(82950400001)(107886003)(66476007)(55016002)(8990500004)(10290500003)(33656002)(4744005)(71200400001)(5660300002)(316002)(478600001)(4326008)(26005)(6506007)(52536014)(2906002)(186003)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nYqoZSaNj3iNS3gn+ThJS3cxSR5QLiINrx4T6zSoHjF57cyEzq/QEnwiwgb/?=
 =?us-ascii?Q?dYL8GVBDf8R53X8B3FvRRYSyG+lEpugszqMczfZfCVa9hHb2JDQE7hDfAYBI?=
 =?us-ascii?Q?DnfDM1drOmNlHIkIEL3zYw+juV+glA6RiN2N3PqlgrXLMsAqj2GvZl6q4kU7?=
 =?us-ascii?Q?UUYbeWIUTDGmRMaMPhDe73azuIZD5Ejr6py4wAHob0/OHBdcECru4CTKZPvN?=
 =?us-ascii?Q?dv0HgHgSdJ9/c0YB1NXAzzEDbI2EGqv9kXMMnBkqkZ8KHN6KDhTwxrc6B6Yc?=
 =?us-ascii?Q?NmuQdlMo0XGZrzYKr80pyxFlXo/78OXOrexzgiQoTrge83SW57eRBrDpNX3H?=
 =?us-ascii?Q?O8V9uCB7HijiOSAkM/viA3RpddSAvxq0WyGEu0xbBUcVUyKALiuiBt4TraZU?=
 =?us-ascii?Q?UlLa8llkrwxso0Ye78phdliSzBWQnUo/Su2JE1Tga5VFEoQuvHWtkPPBrnuB?=
 =?us-ascii?Q?dRcBE+SQO6R+5uaDgVMpI8LLhMg+RJDCQWRiBz5zmsDMrQwOHqudlYQiaDCb?=
 =?us-ascii?Q?mOlMoPFoHiEfWWW8GKQ/YdpQwuJPpeHmbJ131rnNBUZeR5vrvFloSDkzXyqd?=
 =?us-ascii?Q?wLK1XSVMJHfRqWX2G7IN2TeUg0F6EVQMJdxlDqas3y2MQgkOVxwuFVEh15/U?=
 =?us-ascii?Q?LD6Tpzs3PeGVkAQJnywk0MDuPp+MrE0IlbgcmBCXJ3gUBd5z2EhgV8DKpvyK?=
 =?us-ascii?Q?PKkwBTRQZG/GtRR84HjUd//K+MMkMaJ7tUkRnTt4WTB1xcjosX22Dn4st0DN?=
 =?us-ascii?Q?oG2h0dydiLU8Z8mNNNyJ/O3ZmIVW5gWjj7rkErzavnq/mQBM5Xtkn1zKHQxZ?=
 =?us-ascii?Q?EbQpsevqyqOCF8RLpXMUvd/l5u/zgwua2rljXCfVDZDLLV/h+wZI3vhKlXep?=
 =?us-ascii?Q?cYQ/uWuoHrSjosj0YpHQ/FWcPyojYvz0fG1+QJ+EOeXLWN+spT0rC0D4iQao?=
 =?us-ascii?Q?7kHYVBHXVHG/pWSpHSPoW42/6r19aakTV7wosFj7dkzvQu4qU7xb6MGQpCv0?=
 =?us-ascii?Q?tcNf/bez5KiFC/9nDKQtwuy76xC53ZX0UwOXZJC/ciRhdmUpDZS/NRAfTtjp?=
 =?us-ascii?Q?ObB6iQp2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8ac8eb-9759-4d37-8a7c-08d8c191e171
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 00:32:36.7729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6EvMcn6J52Eq1JU1WnWuf7uz4xQgSZXUYH2105iYiVv9IWey6OdR2/gB+NiLfiS4ijv7DA8Xgw2BUSWKB+Jp+MSYGvUcsy+fsCHIqPAzUJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0862
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 A=
M
>=20
> There is no VMBus and the other infrastructures initialized in
> hv_acpi_init when Linux is running as the root partition.
>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v3: Return 0 instead of -ENODEV.
> ---
>  drivers/hv/vmbus_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 502f8cd95f6d..ee27b3670a51 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2620,6 +2620,9 @@ static int __init hv_acpi_init(void)
>  	if (!hv_is_hyperv_initialized())
>  		return -ENODEV;
>=20
> +	if (hv_root_partition)
> +		return 0;
> +
>  	init_completion(&probe_event);
>=20
>  	/*
> --
> 2.20.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
