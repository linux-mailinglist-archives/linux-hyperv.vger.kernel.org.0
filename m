Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378DE49E6D6
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Jan 2022 17:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243311AbiA0QBc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Jan 2022 11:01:32 -0500
Received: from mail-cusazon11020020.outbound.protection.outlook.com ([52.101.61.20]:47954
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231296AbiA0QBb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Jan 2022 11:01:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FM6v0JI4+PZ02myH7Mw9YDKwJjmi0f56hHWfYic5GSIGdFYgp0ye8ln2S7g6O0XXwUMJ51CesQ/61pEWUtWPmV6ZbpD/fKBeisA9tzOO3Wy3Cu3LnhDrYpqk2LpfRSl9jv4XWY+lS5UtB8AuA5Nyy93ArnQBqEsioC3Ys6HiFIa2wDcWFPInObYNMgESyGjnUM++kEy9doMTCJzkr1HGUYi/GVlcKPa06evCFU+v5o3XzbRewhyXTob0V6hFDcGm7NYv43U7PX/90xGElmxjVL3scNosiTmt3RvgcvpNeFCvEYnCEaaLFb/1PPbAm0MtBHsJZ3wIhDucORJgeFf3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXEOb0TM+7uynDXp827h7+abmbwN1ygOvFN8PqGSDLA=;
 b=AY58P43hbmtyslclXHHJa6SQZbFftzgJ033LNsYYTp5HCBftRqE3g5BylqJg5CpccpZsIOzsKaxJyZ41wONCm1yz5ZulgE/z62nNrEg5VCFj1/AOyXliBw+dDIj21Xb3DwOEaFNrpxBjlnhlgi23Od1regk+/Q3v0ZLFVsMP7TQkZXFYBGJM67OpfrfLPIs/Tq5KVGfdwMg1LDwJwo68QHhyRtiUVLUjy32nyQtzEgPqtWdY6fQpp4yDc5JZGOC9jwDX49tHJj5RIe0iBfl9ywA5+882jZQqiJOipwuGjEMCR+7IlriYeFbv9RClfjdWuyGawggh06Iw+iF2j6CGmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXEOb0TM+7uynDXp827h7+abmbwN1ygOvFN8PqGSDLA=;
 b=HYgFDBoUqiFKZg2bFh9jlJdT4d2OS/+TxYpvF0kfA8boWh1CkcX2fRAF94eyj6B3ZSZxLQXPDNmy12Qyp3HEPO9hUlsj/YwYtEQoPjKuH0UVgjM2XPjhRKU2590dVWFo5oDJsB2E/9J3aBaU5suoRblUqWE5nap6gP7q2ZKpJUE=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by SN4PR2101MB0815.namprd21.prod.outlook.com (2603:10b6:803:51::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.8; Thu, 27 Jan
 2022 16:01:29 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::61d3:a4c2:9674:9db6]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::61d3:a4c2:9674:9db6%7]) with mapi id 15.20.4951.003; Thu, 27 Jan 2022
 16:01:29 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH][next] Drivers: hv: vmbus: Use struct_size() helper in
 kmalloc()
Thread-Topic: [PATCH][next] Drivers: hv: vmbus: Use struct_size() helper in
 kmalloc()
Thread-Index: AQHYEikr/2Ofcu6A+U68I3R7gLJE+Kx3CXyA
Date:   Thu, 27 Jan 2022 16:01:28 +0000
Message-ID: <MWHPR21MB1593A23CA620CEE3557023F8D7219@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20220125180131.GA67746@embeddedor>
In-Reply-To: <20220125180131.GA67746@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3e0a4ab0-c4c1-48d6-b02b-c5a68070a479;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-27T15:59:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67c5ba59-97bf-451e-c9fd-08d9e1ae479b
x-ms-traffictypediagnostic: SN4PR2101MB0815:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <SN4PR2101MB08157B22042CAB0830C79D95D7219@SN4PR2101MB0815.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y4Mgu4NRVTba9ZSg69np+0bfPvPB5hTsIcWODwgyTmZVQT23IjyJ/m2n2hHW5k2zZWKm5gxjWX11QmMW4RqlZWe/jVV3XAg0PmPpL6ezdETwgN9Ao2cYoIWHpyMfX1tQIV73Iwa+YFwSbVWFJzr/+TbgFbR5CoY3Z2lHzNhdV+YowytEVkA2hqtgJDCuFQcz+twhIpUvczW6kDIn/WuZ0UX+MARBxFzmfhuzwLNNW9P80kBvt68yU952WrRwd85wQVIH73oA0quIUTMTdPv+TvoPksN02vmpy/RFsi3M19uQqlggHbjyWcl7CLwwFAR8WCI6eb7aBUo+GizcIRJyECC3kWRVjkgD7ZuDgoX0kjVBChBldQEA/OJF/a7aiLbNNPhWZzlSBJ0r86HlktRI7IBJYuXIr9CWCGlTQRejQVCpQvK1I5j15gWM/2MSAiUUg0sxywrxx3vsMV7G8SHlgAQyPWwyzEvUn8phR6j4BczLdx/ZZdfywQTfod5Ntz45LAuORKxaQ7ZcL8ZIj3+7/KbxYcHN52xpjDTiAG9hfK+VytDUMhnT4EFGHaRyJrA90kCFkGWVYc31u8rbOzCFdOqfKPW/BYJFTcFZFqZqDBGQeaTZNGUFLILjXMMhNqT+Xta07BG2v5sBMZzN0MwS1RycLaIetIzRK/txDHMTqGpcwh+mXqmyT4m9KbHj2V/L6Tmnna4oW6rB54y1mCVjzF+y1pEm4wrfevcUAlKmSGBpYHw+ryNvLI8mXczxTWYWamW8EbGnmimZHb54xr+8cs1viP9hTS+1nSW+cCzgpE2mb/5BTLb2zBSjILSXZ3n+NMWIj/adFyZMBs95m8DAKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(6506007)(7696005)(5660300002)(76116006)(55016003)(33656002)(54906003)(8990500004)(2906002)(110136005)(52536014)(26005)(71200400001)(316002)(122000001)(38100700002)(6636002)(82950400001)(4326008)(66446008)(66556008)(86362001)(64756008)(66946007)(8936002)(508600001)(966005)(66476007)(38070700005)(8676002)(10290500003)(9686003)(83380400001)(82960400001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k+qlA19TqWCIAufJm7ynd5xTZ/uo0CdqHzobWiB9yIrjtvMLN0l2rMd3Uiz5?=
 =?us-ascii?Q?XTj4LvOwoXcccfImNfM9mECLMcgLHO3Tq05AKkgiyrcKztYpvhFxnpVOCJEf?=
 =?us-ascii?Q?QsxNi77GMDI8Q6CxE4nUNdSFmCv3CRl0J8zsjZVSAs3ya8ZK69u//QKzVxt0?=
 =?us-ascii?Q?J6QQ5hvgEsd6K7mqE6owRYv2xQQ3tYA5vM3550shF5F90R+o0rPrw4riE+YC?=
 =?us-ascii?Q?m6I4bibn53cLN0Snu9kPuLQsXivjp/Njc9hQP7zJ5fjGuGXuEb0zfFUXM0LS?=
 =?us-ascii?Q?gUVWVZ5+XSzfLZPmyzJZdSUKgWyMIt9V9B36lFu+IqW1nyrW5XMD5Lt6Zf6T?=
 =?us-ascii?Q?fsaFQnry5nEYpIRMTXCuna9WeqG55JFT6bFCEzrX6kc2THpao5BkvH1KZEyx?=
 =?us-ascii?Q?MrtYBp7YY8p+zejAiUP118ww98z8ehryoABhw73NZnZNqr0qCvykaXr0gvAE?=
 =?us-ascii?Q?6VcTH+8arEl72EH84FmqqsK3Qgsf7nvbvH3ZyEMi98uF5KHtPaxjwiuWukPr?=
 =?us-ascii?Q?atMxZ7eR7aHUZO1UPMQvn0wzksFiu+CSSefufK+qQ/a7k3pd8r6DmmR4mK4U?=
 =?us-ascii?Q?xovliO9VKgAbAGT/p3OwUR2Q3QAAJrc7x1OYcP24yWRnlbktdlaKFIaqBIi6?=
 =?us-ascii?Q?w7nNPjHN01KYNI6Xx9iLQOMzBAThEW8pO/UMJ/a1g1CY00vtVPU37/yO0X3A?=
 =?us-ascii?Q?57HIgj6tTlKQyoSuXoBTcb2L+jS4QHaJnL/c9k5oTCyJoz96vb13tqhdORib?=
 =?us-ascii?Q?Z36Nynfo9fPj2tJGCEHAe3EIZfxp+L2a34LETBrnRxRKHTEF1xSnV8RfK3n8?=
 =?us-ascii?Q?AqDcCm+hmPsUaYJa/c5kdLqAg31YgjB6TsaGoKqysaZMgbWJGY4u6zYK+C2Y?=
 =?us-ascii?Q?2BV9zjFEc35jsjjkFNMDPnNS8ynStkdE42CJRXx1vNDgDf7p4PZ3/5ilhABi?=
 =?us-ascii?Q?z7bRxCxQSLA9YwdvKAz3488TDSaLUyolQFcAYKANSd+JigwNcHSwqj+IbHbw?=
 =?us-ascii?Q?GkMp7a5N/75OVFsCduiuR7FhHql6vFVjVBGGjADQGFh8BS70unjJQP9X2x15?=
 =?us-ascii?Q?SU1wvpqa3OU0V7bndO5kgBgEK2jBEi8/MZvKOhUYauJujBIZ0oAJPfpkR6GU?=
 =?us-ascii?Q?Hvepogrc0eyudcDsYZLeLK55Np26ECWFGc6FI5dR35UCm2uwhhzRRoSIALxw?=
 =?us-ascii?Q?9pkB3NgEybfv3d+Mo6piEiqaAiGqs8S3BtJ8nW1E6+FDaQgOvuX0eQJzaRuX?=
 =?us-ascii?Q?l8gFSNSBT9udPr/+gMYjlDUGn+ky1OyLzl/fsDWE1OYHCmoD2OZEfWzy+xwb?=
 =?us-ascii?Q?/syU68r5e8fw3Nm6ovCQb7KeiTR4hy2+SsOQmq2O9A+Bl3YMtg/BRUu+A/YC?=
 =?us-ascii?Q?uHLtgcafqKLFNdKyCOu7G1bGIx2EmJS935bN26p3QCA7LODVpMIX1v5dbQtO?=
 =?us-ascii?Q?gqaBVO3FYZ4gatfn3gH/ftqPYDcSbm7olV0+lFjskmrCw4Oxd38bOw0MO6Zl?=
 =?us-ascii?Q?dSGxN9rqEkXxasSv5+q3IjrbzwjUcbk+xITj6gaI6QdhzoboS7cZKMj/GEor?=
 =?us-ascii?Q?WELrXokLOxkHCurtecGKqmaeKOwQRcqIeF3GzL9c4biYSEOXfOA8RkkIaI3j?=
 =?us-ascii?Q?cvourguVJFcaahFUkdh5O1gv/y2Hmvn9HsdBLKYdZwHnC8ZFx0QBGkClkPoz?=
 =?us-ascii?Q?QQAclw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c5ba59-97bf-451e-c9fd-08d9e1ae479b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 16:01:29.0137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dTgcT1Ag8vb27YI6SHhl/ksvVIT8VXNxNlCiu7tVrhWeCHa/VuQdUAVDQYEwMUwWKEtp5EghQKngoCCPMrB5BsmanYNmUl/IcgWFoooJ5cQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0815
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Gustavo A. R. Silva <gustavoars@kernel.org> Sent: Tuesday, January 25=
, 2022 10:02 AM
>=20
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
>=20
> Also, address the following sparse warnings:
> drivers/hv/vmbus_drv.c:1132:31: warning: using sizeof on a flexible struc=
ture
>=20
> Link: https://github.com/KSPP/linux/issues/174
> ---
>  drivers/hv/vmbus_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 17bf55fe3169..cd193456cd84 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1129,7 +1129,7 @@ void vmbus_on_msg_dpc(unsigned long data)
>  	}
>=20
>  	if (entry->handler_type	=3D=3D VMHT_BLOCKING) {
> -		ctx =3D kmalloc(sizeof(*ctx) + payload_size, GFP_ATOMIC);
> +		ctx =3D kmalloc(struct_size(ctx, msg.payload, payload_size), GFP_ATOMI=
C);
>  		if (ctx =3D=3D NULL)
>  			return;
>=20
> --
> 2.27.0

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

