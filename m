Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683D24A9CAD
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Feb 2022 17:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351504AbiBDQK5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Feb 2022 11:10:57 -0500
Received: from mail-eus2azon11020025.outbound.protection.outlook.com ([52.101.56.25]:32165
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229713AbiBDQK4 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Feb 2022 11:10:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2lHfVMwua6q+aj3TQGeo9iA5UAx9VNVK3fSD2WuYlgAbV1mKZjbHldo2DMZgYbjGWhVP4WkXWl//d1lGTZ/BBWdkokeqWqU/hpnozHD+WABK1zHFpfPdyLWHxH0skzqdu3ECZJ7VMp/84JpE1UPYWjRBP+3cfaIynC9yNEbfuniqtn7YmPB3bthkCgKt1oe3w32WsQfZnNq2oPtN9zUauLRgAoe1woUxICk0ycu14wN2+s5cdkM2FO2yjOxRZdgqFEip9VJJSJSJrL3xD8eZkSrwufd3V6kn5crnDCne5C31XZuGE8DY0N4i+CRrFHiABT7zVVM11e8y+ELxSzI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpFM+x5rFT/1/vBWkR8KRu8wETovPWwZAMiJYzEQ1+A=;
 b=D+rnNTHCVp9E/GIJ3oz+EmLrof3I+CuP9niAZNv7bTsNq0wN/6f6CGCBQtETJYtOXh0tswrxXRRfVdJIi0d55ZoiNiPAwkP5fDWdkwKm+ADjE3Y2Znx9IHlDFRjL+ZeCOmcQRoELh+WTr+JD2tvGXLFae44460KffPxgizad1o6RPNEJ/9zsVfb7qvpfPziah1fJZifzKDoqKNOmZ9047QM+UU1+zxB+uqM4/9PvwHwSGIeX6/EP9x5h8Z4KdNa8+XZSS/Gcsc6v4pPK21SpwTvvzdW8j+N6EaR82aUGVQXQO5RUjdKr5oj5vzq26RKkZrEn9zdWh5wM3ije64hJew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpFM+x5rFT/1/vBWkR8KRu8wETovPWwZAMiJYzEQ1+A=;
 b=MEUpEWm03vGfsHJOeRf9I1Z/pcmQkWQEN8bYdAxWPDfQZSbaXSA6sX6b12zsExLvEB+PnIttlWWMcwvVQR+WLsc/bLRkhCWydsIyUnSNP70DBcg62VJZQOyKl/42A9NdRHQ8qbxEOxE9WfxsqylOOINfKYgM1Oslac4UxjDXiU8=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by CY4PR2101MB0801.namprd21.prod.outlook.com (2603:10b6:910:8d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.12; Fri, 4 Feb
 2022 16:10:50 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e827:5c3c:bd09:4b15]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e827:5c3c:bd09:4b15%3]) with mapi id 15.20.4975.008; Fri, 4 Feb 2022
 16:10:50 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Jakub Kicinski <kuba@kernel.org>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Long Li <longli@microsoft.com>
Subject: RE: [PATCH v3] drivers: hv: vmbus: Fix build on Clang 12 failed by
 DMA_BIT_MASK(64) expansion
Thread-Topic: [PATCH v3] drivers: hv: vmbus: Fix build on Clang 12 failed by
 DMA_BIT_MASK(64) expansion
Thread-Index: AQHYGcfiL6mJfsu6ikmY3gkXhysF6ayDjiqQ
Date:   Fri, 4 Feb 2022 16:10:49 +0000
Message-ID: <MWHPR21MB15939EB2A75C96B2287B38DFD7299@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20220204130503.76738-1-vt@altlinux.org>
In-Reply-To: <20220204130503.76738-1-vt@altlinux.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e9a2d342-4032-4624-91f2-c4211d52b53d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-02-04T16:04:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f29b51a-aeaf-497c-9484-08d9e7f8e945
x-ms-traffictypediagnostic: CY4PR2101MB0801:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <CY4PR2101MB0801AAFE87289287E0624C0BD7299@CY4PR2101MB0801.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7shtYgmLezVBUAgoBmH9bMrHXbgw1YfuulmWaymDNn6+Ia8gQLMpzer7cBkagn4z3MEit5wbXMH14yCyA/SLcZ19ZQKkVQ6uvKPwATZVCA2OjhecivY+ni3n8+TOV1YDzRhTYpplUp7TEtd/JgOIr7Oiz4NiYbalOOckubm5KDrz17BmLZCqu2gtqnUXRiapc8VUbB93XnnYzsoQz7ahmxrx2icrsCk2u2llQdKbFIxpsFk9Nl46KXWQFZ9UG+0Oo1OfX4LAiouXMXdRCpTNHIqkI/fOgElvwMuDGk0o1IMvfMgjYU1L00vfPMhM48ClEaoinRk+MSRxytyYahueVoS9dGf9w56LCrMyvea+h8TYShT/RYHonGRb9mHe7Wx/3V8iAre87gzqQZwu0fvWv0iPdtujqwntbHrjdnQtNf+uKk2B94UDc1zVe3jPwoO/tU1KYeiup32EuT40F26HKV7iAXzK+i1wB4g1WG8FKE7T2O97d3EuIVZ9zyQeWlMx9VFSOVvGAT/hM952vVx0lt0b0Eqkw6QtGuUzC4Gu1Omm1S2yV1c0VRniWHO5ffxv5MNj8uGAd1be92DIlJN3Ihx+V3C/PVgmuktnssKlQQd3+SO6WXkbVzVpevT22wfXPEmnnTKmNIWDxPyNrhIHdD4ZJJlbaJ2xtbSJQb5IJ+r8NIXJHJ90x2T/d1LBJv+lCI0b0d/oHyxsN5M3j8G6I4tFdyGbOVvkWfxyky4OPF/tSvxN698Et3hsU/40rFuG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(55016003)(5660300002)(4326008)(66946007)(64756008)(66446008)(66556008)(66476007)(186003)(26005)(71200400001)(107886003)(9686003)(7696005)(6506007)(33656002)(38070700005)(86362001)(122000001)(38100700002)(508600001)(8676002)(8936002)(52536014)(2906002)(8990500004)(10290500003)(76116006)(82950400001)(82960400001)(54906003)(316002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PUyQxM5/kTvtsdkGcbNrMadU+KJSicbcSy04mvbd8h7P8vpFoFNg+q948PlT?=
 =?us-ascii?Q?GZguclOfSqO6uKXxR+1IejuzSdcMqM9l8/O6Jelm0KXXF4hW7hN+WFkQ2nfy?=
 =?us-ascii?Q?g7l8AyHDn2dNt6l+LtJ2hAfy+pgV3XWuSYegORaT/fMFGPjKm9tQyCtuDbBV?=
 =?us-ascii?Q?VphRsX2VYZ00cRKg1oM+9s3nOnO83qMufMbTcEMUqhlax5Td8ft88WOhMd1V?=
 =?us-ascii?Q?4KmGzjHumwJX8DhB36HvctGw7mhTXoVf/uuI13PUr3WjiRCMXVhExE4kRtrZ?=
 =?us-ascii?Q?MRu9nG8uwOEsnu0+rEDSPtrzPLoxAAci1CGwV18g7K3WVI/QIInaAQVKkoFP?=
 =?us-ascii?Q?i+7XQul8CtymGVnEbqbdG1TfkZ44jF4o6efDDWkR/MR7I5/Wr0FUvGUfpRwE?=
 =?us-ascii?Q?3Qhg2fXTWr8EWO9jMnd/uZXZJCir90KPSObkCXVbHL2ccp76aYx/WdSGnS65?=
 =?us-ascii?Q?mPRNqgX4BB0QYnyeMh6SsEGZ7jrM8aHhEEqp+jHCckDj8r2reYA4470M0P35?=
 =?us-ascii?Q?GNdjjzj1p4MrbGUQfn1zbfTLq7UsUylGcz4egaV/ufJDcPeNeL7U1SGqXOD1?=
 =?us-ascii?Q?EcqrYpKhh6Fc1MFiPTulzpFdD6IKUEVG1xOxMlxCa8kw9K58UIbDXEaCddfH?=
 =?us-ascii?Q?3bGYVzpqQ23gn2WhvSHS0dO/cdFOqknjVodjW2rfiX18IcEsBAzyaM+g63S5?=
 =?us-ascii?Q?X3XMysAjQh0VE8q6L6GDKmoiPx2kBalWX9lvbbxRs204mNmMLgr5QXhs2fFB?=
 =?us-ascii?Q?dopmMTdF0sY8esJHAc1ZeZa6QKEIUD3Aa4ZXPLLr/f2Qdwv80Yf3Gt6wgeYN?=
 =?us-ascii?Q?ts3wyKcmDqNCNRLYFzFkZbecr/kObz7bRqI3TeHBGYfqzUWsX4b1EoiKeh+6?=
 =?us-ascii?Q?Isd8DQsoWSXnDtCys7MZAIHnLtdhYrl0Ni3R8UdH/g+aluQxLsbrjfyesKkt?=
 =?us-ascii?Q?uOWyrfXQ1cOHD197LDo4/zmv8hEoZ0zOxo3ADfz/Xu+iTUUFwe+1YtHEWRS3?=
 =?us-ascii?Q?+XSXrkV9PkS+gBkuSdoTksJSSxlx9jGBzgY6ezqpuIq864RJFIFzaT7vtA8h?=
 =?us-ascii?Q?1vIZAjzDZKtjwkeQ9I02960MQvEry5GuJEzgIjGb29mid1htLxQuMtXdH79W?=
 =?us-ascii?Q?5N4PNSzY6o5FMYr8izUXn+A0k9PrRU1hxF6r99gJ9JctuCxZBDY871SwnLwd?=
 =?us-ascii?Q?Xa9j2SWHmotLbenFBdbPW3MlahpYPjdUXYrdD4UuyNEHeIqoZ6wNLT4C8Y29?=
 =?us-ascii?Q?F1WAH7XqhcZIES4kUcNTjmtdEk57ohXdq0XmlnMEtbPHvMDKxo+gkWNM+3Ce?=
 =?us-ascii?Q?4UsLgkPY6MUifkb2T2vCguQaxC3YDyJeyUueSk4ItRPi4lnLHosrll2jpAUy?=
 =?us-ascii?Q?iJRzjBurmQROLh6+QiNIboMfN3ooD8u0+yXRI4fuxckB8CgQfFNDQ6f8W40a?=
 =?us-ascii?Q?fmlC+mg/wVR3N7sUyXOrsB/ueHc0Sb8nuo5V2qURkoX+7IuEdjiREcXah3cq?=
 =?us-ascii?Q?tnfJpYmoIGucSZVUCsGNR93gI7cIVovTInTuTmzcGOgpY+M1IFQ051vlWTH9?=
 =?us-ascii?Q?1SQpKI2hKvQ13Wf0oKVWFh6yMIx1TxIFOnbQITqfQxJyP+LwWCYUHqKfKlre?=
 =?us-ascii?Q?z+becw4ST+TNVUCP3nncIEq4hmjoNvij2WD53V5zmC/Im3DVjKoF+8EmRjQC?=
 =?us-ascii?Q?Q8dKSQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f29b51a-aeaf-497c-9484-08d9e7f8e945
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 16:10:49.8193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L/FDGAtMLnDkOcTDm/5yhCCywziUE3cseexxcCjg3fixLbPy9b3+l643GiXA3ec1GKFC+6SX7VhCdv7//yq1p4ZVik2gSq1ILozl1gCRhBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2101MB0801
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Chikunov <vt@altlinux.org> Sent: Friday, February 4, 2022 5:05=
 AM
>=20
> Clang 12.0.1 cannot understand that value 64 is excluded from the shift
> at compile time (for use in global context) resulting in build error:
>=20
>   drivers/hv/vmbus_drv.c:2082:29: error: shift count >=3D width of type [=
-Werror,-
> Wshift-count-overflow]
>   static u64 vmbus_dma_mask =3D DMA_BIT_MASK(64);
> 			      ^~~~~~~~~~~~~~~~
>   ./include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT=
_MASK'
>   #define DMA_BIT_MASK(n) (((n) =3D=3D 64) ? ~0ULL : ((1ULL<<(n))-1))
> 						       ^ ~~~
>=20
> Avoid using DMA_BIT_MASK macro for that corner case.
>=20
> Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>
> Cc: Michael Kelley <mikelley@microsoft.com>
> Cc: Long Li <longli@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>  drivers/hv/vmbus_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 17bf55fe3169..a1306ca15d3f 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2079,7 +2079,8 @@ struct hv_device *vmbus_device_create(const guid_t =
*type,
>  	return child_device_obj;
>  }
>=20
> -static u64 vmbus_dma_mask =3D DMA_BIT_MASK(64);
> +/* Use ~0ULL instead of DMA_BIT_MASK(64) to work around a bug in Clang. =
*/
> +static u64 vmbus_dma_mask =3D ~0ULL;
>  /*
>   * vmbus_device_register - Register the child device
>   */
> --
> 2.33.0

Instead of the hack approach, does the following code rearrangement solve
the problem by eliminating the use of DMA_BIT_MASK(64) in a static initiali=
zer?
I don't have Clang handy to try it.

This approach also more closely follows the pattern used in other device ty=
pes.

Michael


diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 17bf55f..0d96634 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2079,7 +2079,6 @@ struct hv_device *vmbus_device_create(const guid_t *t=
ype,
 	return child_device_obj;
 }
=20
-static u64 vmbus_dma_mask =3D DMA_BIT_MASK(64);
 /*
  * vmbus_device_register - Register the child device
  */
@@ -2120,8 +2119,9 @@ int vmbus_device_register(struct hv_device *child_dev=
ice_obj)
 	}
 	hv_debug_add_dev_dir(child_device_obj);
=20
-	child_device_obj->device.dma_mask =3D &vmbus_dma_mask;
 	child_device_obj->device.dma_parms =3D &child_device_obj->dma_parms;
+	child_device_obj->device.dma_mask =3D &child_device_obj->dma_mask;
+	dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
 	return 0;
=20
 err_kset_unregister:
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index f565a89..fe2e017 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1262,6 +1262,7 @@ struct hv_device {
 	struct vmbus_channel *channel;
 	struct kset	     *channels_kset;
 	struct device_dma_parameters dma_parms;
+	u64 dma_mask;
=20
 	/* place holder to keep track of the dir for hv device in debugfs */
 	struct dentry *debug_dir;
