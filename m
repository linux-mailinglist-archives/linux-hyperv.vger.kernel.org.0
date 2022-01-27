Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF50249E6C7
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Jan 2022 16:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237894AbiA0P5m (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Jan 2022 10:57:42 -0500
Received: from mail-mw2nam12on2102.outbound.protection.outlook.com ([40.107.244.102]:17248
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231296AbiA0P5l (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Jan 2022 10:57:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdYNtPLe5fcJmnCODTDYp1F//KUS+ih+8Uki4K7CKgN/CdokvXucrxKrVYLAfYqR5G8Vm3VO3pxMEboom6aY3ad8rkqI2j88XbJ7m14sfRGy1gAppofUNSeluurrVV3sSMafwP1aMM+HhsBMe3EWe65J9Kep+BO6M7oMSaOvWzgJOETzsBqCQQRzgASlL6NMz8ONB4Ftjm1CrLTj2j4c3wRtdVSUP/3NiLo+kSJVdk2XWdn8TbzYwh5KDscmdZrc08tKWmJT7SJZhjGJ6gcE15mga9f9MjVbHlHWkCoDrqMCj6oPByULmJP9eBnDygSW5qSA7JR6YKHrbuDlzCO7KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ocg/1VDY8xnI0bm6x5BoPnLV5VKXYsNJmPqCbtP6+o=;
 b=DpgwkKRU0SfzZ/K57hta0e2s/w0trJt2ulxYe3AHgMOC25MEUGuB+xtha5yP+4Yoy5aPHGe/C6PkLcR9Zq//aSXppCwSLL56/qb8DBjfveP7z6sdW25eLr/TnOfqCH1e/etiSnbz4KtKXNnnP7xxtPLrHuCaQH0mXqLFGwGUvZPtlIAVngM6wzAgOKaqS8J4CyXL4iVroOgaiP5ScIOdZ+SvsSQ6KjkODQXHckpxnL97vsBbwAc8noVWKwihgogYtXnmBGf4uTR8jo/VQTs/jeK98yY73nvrua/qSbM4EekQIZqd2S2q9Cz22+BpfB5QxhoFOyb3R7cMZQrfP/uxtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ocg/1VDY8xnI0bm6x5BoPnLV5VKXYsNJmPqCbtP6+o=;
 b=DIreD4DU95dmaU/jeImM4gWNgRiIyCJyIABW04bsY89mtxi2dsRAoFOMVsZhkoOuwBDEyDUTpUiGleadZMNjQ36paoewbE+Ivwbb3jWsvx/hoJF1NamuiZ4DSCXJq1jptOBARtAG97AK2UL16cuTe5q40h3HxWzzDyj8BquH4/M=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by SN4PR2101MB0815.namprd21.prod.outlook.com (2603:10b6:803:51::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.8; Thu, 27 Jan
 2022 15:57:39 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::61d3:a4c2:9674:9db6]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::61d3:a4c2:9674:9db6%7]) with mapi id 15.20.4951.003; Thu, 27 Jan 2022
 15:57:39 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH][next] scsi: storvsc: Use struct_size() helper in
 storvsc_queuecommand()
Thread-Topic: [PATCH][next] scsi: storvsc: Use struct_size() helper in
 storvsc_queuecommand()
Thread-Index: AQHYEikgTbbLuyUPLEGhxYJ0QDRbbax2/aUQ
Date:   Thu, 27 Jan 2022 15:57:39 +0000
Message-ID: <MWHPR21MB15938FB5FAD287035218D969D7219@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20220125194213.GA74670@embeddedor>
In-Reply-To: <20220125194213.GA74670@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=260747ec-734e-432a-9438-219b692c43a1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-27T15:17:23Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3abc761-e893-478f-ce77-08d9e1adbe8d
x-ms-traffictypediagnostic: SN4PR2101MB0815:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <SN4PR2101MB081520B64E300A8686AEA25BD7219@SN4PR2101MB0815.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TwqbtTmJDzMm2IsW7f5qgDzmbCa/dfC/n6gkG9u++TSvkII4IRTSVQV2uqzyfgv91r402eJz5G6EYboQ+xLn5ygxSFansDZ742yyBZZaEx/S86tZQ2Shy8QWF50L2l+f3FFMIkMH5sXa4TB02eCAnX6IbsBUeAIIV2LY+Fph3AZjHXMgJxmmzc7Baa4rs87lj7tMlE7nRzXp8cPvF7AtQYHVg66vMl4YXJt/bIjKk3OuWwLLeoOO/vI5Xi4DZwaza6hofNi4DZfFacO5nDQAldXo0xqP33EBJV0JORvourCVkdtwZsVHbbffN1K9KpXRlO5+TAV5hjR42pIku2c807nozXk8gKMcse6Lm36Nb0LqwOALgQVaj+ma7c8fyTBUNEoBpltalRufzmoIwpwM/c1xHUXR0wWy1EE9xzgxt+ECJ4HrluZtkXv3eI16Uig3uzD4u0xuQt9Ci1SIJr3uwN+bF7Nxx9aYyeOstv0rhxjyfdR4sLUv17HmJZDjCYucRUX9APbNuo+APOLpAHq7M1953FM6WugGn5cYgIzL40Wv7NVoY0hOi63apyiQpY66yRVt/BQ4awc0espFX649gyKXgnfqUyQf5R5XL6e67LSaZLjCQvs9lR+iss878+EoNO9V4HH1kohM9B3Sd0TJt/uAFKi4QR5ALB5lrh+y9NqUEAjI5FYFDrD7wS8bmYVHLwzs1Q2c1t7W/vSS3b/UJJN9SNunyOO9fju/StIFQ/K2as+0AZgtKrRxtR3CkGEUYXcPK0aiFmtU2FslWvHqbDdC9j9mp1nuwrKdgIT+qSO5AzWmh4n/z2HFXCu1an2//PPLnMCHelIn0Wtd6AqB4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(6506007)(7696005)(5660300002)(76116006)(55016003)(33656002)(54906003)(8990500004)(2906002)(110136005)(52536014)(26005)(71200400001)(316002)(122000001)(38100700002)(82950400001)(4326008)(66446008)(66556008)(86362001)(64756008)(66946007)(8936002)(508600001)(966005)(66476007)(38070700005)(8676002)(10290500003)(9686003)(83380400001)(82960400001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aS9sSO25nyvGnJrVqPnPSbe3Un0/dupcuahWvOyHNTdlIrBbmcqPXx1pvMpl?=
 =?us-ascii?Q?/qTp5g4qjELXasqORJdz0HPJOeM+7IYV7qVw8a/0A5dwggDnGKnqE4QdVzdS?=
 =?us-ascii?Q?2MX1KmAd0mN38Qia5vk4bevxEy0O20NjNq6nPtxJZOsOlT4B4x+TJy6l0ZS7?=
 =?us-ascii?Q?mXWv86PTFLdljf/af+jnWA6/CyYM/3X3SpaQz5rYOAHEdc6ISoGdcBiq12X+?=
 =?us-ascii?Q?1cJnrxSAesnIohRPkG/8hN8t/VFUIPHqpVWv0LA/4KcSzbEiRR9Q4Y97B2Zb?=
 =?us-ascii?Q?tag+7siCfyPPjiRguKxw6LzW9dG6ibLehCPGeOeDSFCLR+q8W5F9IJJWhwj7?=
 =?us-ascii?Q?YAGDuFa4z++m+VRwrocIB0Rxeaxp5+dgf+chou+Z5nFyjzxJk1Sp69BY3orK?=
 =?us-ascii?Q?1vNnK1SCkZO4+UlNNfZZ1scBmR0L4UX3pd2RiAVp0IX+HQFcv7jxsPNcndlJ?=
 =?us-ascii?Q?fCA6um+BooRd9VwzX4s5d58U1onvjvn10bbWfvY7sjb8Ts9Dyeqvrp50jt7E?=
 =?us-ascii?Q?VXj4c/VLXyF2hymGt1shEKdU8kgxtvZ+IfDyrm7mXYFgGy4HBzPQ7oRoGewC?=
 =?us-ascii?Q?MaT9dRt/qxxcp7cYqCEzAZ+Qn9Kvzn2arK8fue/gLnVomRq/iWrff/Dsy9ht?=
 =?us-ascii?Q?M0p4Lhlzua9QuIgvXUjlskg7joTzzFLPZdItFByye4xISracQ0zRMq+B0Lyd?=
 =?us-ascii?Q?FeDU/mYC1JKvfUnSOXz2tGv/8wKuVDPj0ct9BaRkwaCOHsmJ4L1EFjdusbUW?=
 =?us-ascii?Q?in/qg5FSsTuuXL2K5vU+r9YS2Is8RGRGW00RmPNZAnM7nWle0NuqvY9HoYSF?=
 =?us-ascii?Q?FhzuKTxdKIRBG+K9WwKRxl2pYTtfG4CF2Xt4Ca+Zdo24w7gGsYhQlKM7BpqZ?=
 =?us-ascii?Q?P1mnbEugMID+WLsWELUEiJHb5uWK24A/Fl7LhKSqQzF4aoBw7Fl8DjWEaRUw?=
 =?us-ascii?Q?eXu1QP+AJqShc6MAb8yDmYFGbRx8jBZjaHml55STDJHGxfzsmOjwQaP+WCJf?=
 =?us-ascii?Q?qhfE3yKmFOO9OX3Gtx6G3DsnR8qWi7Idg5vlrWbYKAYfZvbSJsGIpLRJMf1p?=
 =?us-ascii?Q?Vvk07bT4rqZQYBTTmaOhWvS9cVne1bUNwtjYh0qSglAVF66hNglLUZAymRBy?=
 =?us-ascii?Q?DZ01NmFX9yXoQQyTII2YG1+NKFb9c1ROQ5dAjKjzOQ7cXdwzarbbx9IU064p?=
 =?us-ascii?Q?Me8RHeFxcsKkJmxUcJaEFYqP1ibF7FSvu947ooxm5HSoTu3n+P9q/vaDjXUq?=
 =?us-ascii?Q?IfQshvXs/p0WLF4jd2ry/ZMvmz+oZgcyBSKz8v4wIsFxq4mieAKZ5Qg0tjNL?=
 =?us-ascii?Q?cHrmzADQF63xJaKsInyQpnkH9TycG4Eu0cQEJn/nKKCNZUpabg6X19gIfVbY?=
 =?us-ascii?Q?WsynfvDkf2sxN1Bteill1OyExLzO1g1hEuLdsN4cOnHCY7GMb5YWzXt6Rdif?=
 =?us-ascii?Q?7IMKH2zm0aPXUglon0MKA+JsbWJs7fOl1JdcReg/C+kOZgsnEcq8HpKPuoXw?=
 =?us-ascii?Q?G4zemvJYousWjppa00Mg+fIxWK0GXDLamoCR4vP/4JD/TdGK7GLVmaTjkWeV?=
 =?us-ascii?Q?nIQv9YqfArUbkpCE8JoH54BC8H5MKstBxKKE4Gcl7zbZbTeO8TQtcLAHIpWa?=
 =?us-ascii?Q?Ts9PBbW+byPxE263rbg3vS4ZbWykg8E7Dg7GRMWdQj4FCtZaUTWsdGiQkaWV?=
 =?us-ascii?Q?KGq3RA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3abc761-e893-478f-ce77-08d9e1adbe8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 15:57:39.1342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KCW23ofJAzPcm/VCXizjhUarrZx9OmdL86TvaKfBO7PPYlvoAKyPoHYuoVAZMSf7Yo+se6SWtca3g+PQVb785RLFl8xaqENgHm/Gi0KFZHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0815
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Gustavo A. R. Silva <gustavoars@kernel.org> Sent: Tuesday, January 25=
, 2022 11:42 AM
>=20
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
>=20
> Also, address the following sparse warnings:
> drivers/scsi/storvsc_drv.c:1843:39: warning: using sizeof on a flexible s=
tructure
>=20
> Link: https://github.com/KSPP/linux/issues/174
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/scsi/storvsc_drv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 9a0bba5a51a7..89c20dfc6609 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1755,7 +1755,7 @@ static int storvsc_queuecommand(struct Scsi_Host *h=
ost,
> struct scsi_cmnd *scmnd)
>  	struct scatterlist *sgl;
>  	struct vmscsi_request *vm_srb;
>  	struct vmbus_packet_mpb_array  *payload;
> -	u32 payload_sz;
> +	size_t payload_sz;

Does changing this variable to type size_t accomplish anything?  It will
be stored into cmd_request->payload_sz, which is still a u32.  The code
in storvsc_do_io() and storvsc_command_completion() will process it
as a 32 bit value.

>  	u32 length;
>=20
>  	if (vmstor_proto_version <=3D VMSTOR_PROTO_VERSION_WIN8) {
> @@ -1839,8 +1839,8 @@ static int storvsc_queuecommand(struct Scsi_Host *h=
ost,
> struct scsi_cmnd *scmnd)
>=20
>  		if (hvpg_count > MAX_PAGE_BUFFER_COUNT) {
>=20
> -			payload_sz =3D (hvpg_count * sizeof(u64) +
> -				      sizeof(struct vmbus_packet_mpb_array));
> +			payload_sz =3D struct_size(payload, range.pfn_array,
> +						 hvpg_count);
>  			payload =3D kzalloc(payload_sz, GFP_ATOMIC);
>  			if (!payload)
>  				return SCSI_MLQUEUE_DEVICE_BUSY;
> --
> 2.27.0

Overall this is an incremental improvement.  But the code is
still implicitly dependent on  scsi_bufflen() returning a 32-bit
value into the local variable "length", and hence hvpg_count
will always produce a payload_sz that fits in 32-bits.

I would be OK with taking this, minus the change to the type
of the local variable payload_sz.

Michael
