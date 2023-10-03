Return-Path: <linux-hyperv+bounces-457-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE53F7B6F53
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Oct 2023 19:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id D39DF1C20327
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Oct 2023 17:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1F43AC38;
	Tue,  3 Oct 2023 17:13:01 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4744230CF2;
	Tue,  3 Oct 2023 17:13:00 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020026.outbound.protection.outlook.com [52.101.56.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE7895;
	Tue,  3 Oct 2023 10:12:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfqJGHYqyPIpH4yHiqs3jWmo9k0D1tWnqrHOg9d8J32VwciBcV8NhBxv+o1dLRSedhsWzlIhCQJn16Yo/fnLeUyhR0kBx+zDa1QCQUCWO/AwUZFxE8OoYvxE9DOEhaipACCv1pnrnd/uscbbtcGzgrFUQvpRRQ7jDyWoQHBvERKeoXAnVBZgx4z52xrEglLRSptMgAR0XCSR2bMZqo28G9HQ6EmP6puq8MofllArJDrhXQY9shD1MjZ2IyODXZ6Hjv0pDnFlamuRGtUrOTRgBH18bo31ZizB+7y9jjBczu1uKV1Bw7QnUkzNiRAycIIVJYCAznT02kAWFxn6mZI62g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzjXU3rhk8ME6MBY85ODBNeQRd5AKN1c9cafTsjAnw4=;
 b=OdP4P6HWfzdN/tnq93/HmR8vJNgR7JBmjmuJbFlInN3YGV+Fd4zF49vvGF3mYqzk2KUpcXTfJkGIWxlfLOyYU8ezw6qnVa+Grw7IA1QICBcfDVMscGiSek2eM/Otxpftx9HuOg0hau2yIAoYLKvwakNxNCXwgQ/f0+Ej797Ex4ugwwNGMlmU0W1NW5gej8rrMjb74jzBdrIGJmfb6I7kjDre352CroDVmTRqbmHOJdVzQnaZsUBIAu4B9CXJ5Am7Y8U0cdrpBRrfTSbiqJboQ3G3gSx8px70rRgNx7XogiE+xPRPF6hiCx8wqdVZIim9D4r0EoFAB8G4VU34UBX2qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzjXU3rhk8ME6MBY85ODBNeQRd5AKN1c9cafTsjAnw4=;
 b=GaJFfNiSHQw8e/aXughG21jQNnDzrgT3oODGoGNbYDh/eoCPvWsiAfFXhdnejYeaMez5DAMiy/VhFi+7suCL7vZtATz7iVR3B6uFTuZAexo65iaJduc2VgkeeqqxABcNl2FJBgkfX5FsOc8inxA7jBGXdXZAkXELcpictvGhJ7Y=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SJ1PR21MB3761.namprd21.prod.outlook.com (2603:10b6:a03:452::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.6; Tue, 3 Oct
 2023 17:12:55 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ef:cf62:9355:5884]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ef:cf62:9355:5884%3]) with mapi id 15.20.6886.004; Tue, 3 Oct 2023
 17:12:55 +0000
From: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To: Randy Dunlap <rdunlap@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Haiyang Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH] hyperv: rndis_filter needs to select NLS
Thread-Topic: [PATCH] hyperv: rndis_filter needs to select NLS
Thread-Index: AQHZ80ZpAIkCZ3Di40aHJavjr+vJHrA4UmgQ
Date: Tue, 3 Oct 2023 17:12:55 +0000
Message-ID:
 <BYAPR21MB1688523940DAA4DA6E61265DD7C4A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230930023234.1903-1-rdunlap@infradead.org>
In-Reply-To: <20230930023234.1903-1-rdunlap@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4b419781-6994-44e0-a6ea-540fbba3d282;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-03T17:10:16Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SJ1PR21MB3761:EE_
x-ms-office365-filtering-correlation-id: 32435b65-f5f5-4ffd-0485-08dbc433fc09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 niMpW7gfXXennZbYtgekhlZ+5peZhn00czeAwnYgW4DXpAtXdtBbWIx7APQ5pVFUtChOG4UU8cUS5DQ2D6OGweN1Dv9PzggoN3PZoxTN9HPOJDGGjg75ha0lXO51gCh3NVquT+Oh8R8X/ycQbfG3gMMYwUFmyWXmrCWGOGSDX3qhNJ4anzc8gbjG1nZdKikcGnH/YcYTOilytI13GlJOBrBYbbU8yLSzzGJmtZh2z7xFRgBnSaIeFgEqcNVuP+doAUQ1h6bLaVX1Fwvc44fU7E0QeFFTD8DFBXZeiH6PDashV75gMBBTWH2/obhM0paabEWJg7Fu4PJ2/Rn5lxTb/BBrVSvI+zeHdzUOHpOff/DbL0LGYXXh6lTe4TwCF4kFVKULaYkP7VJbOrQJgZ2n98lTduU7zlYEySwPE0/Sncc/V4tlcYr1Z05RgAN6fMGs88rmFtN1kAFJ1z08cANJuhMmvsWRByA64xWeUdaXRY5FUGUGuyOqpXmsmA6cr34XSMFO/8/4tdXgrIFt3gQIyM42r8MQcIhndjx1+ueJjEzpctQEmjDE2cd6LwJYvNtMJ3mamjfSWKcYEfU9tdpqh+3lgrRJX6DYjcO7n4+2w9bw4DSi5wO8MkKrK0O+3CXNd9YyJoMEfjHeMqot97FUOA9PUL6eV4vqofWN6117PMk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(376002)(366004)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(86362001)(55016003)(33656002)(122000001)(316002)(64756008)(66946007)(66556008)(110136005)(82960400001)(41300700001)(38100700002)(38070700005)(54906003)(4326008)(82950400001)(8676002)(66476007)(8990500004)(26005)(66446008)(9686003)(71200400001)(6506007)(8936002)(2906002)(478600001)(7696005)(10290500003)(5660300002)(76116006)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PSEmZv9VxoY+Aagn4WYCkcgXSJ0omPzT8UUyZsv168PP4GPY+cncgCwlYfzZ?=
 =?us-ascii?Q?G/6WeB1LMyf7Cz8fvmQ4+X3xZ1x2DlqjCBRfde5sAzIUaL6iAWMqkaQHQuLY?=
 =?us-ascii?Q?U+graJiQ5Du1OWadT6V6vt5rA6xDsAvBcONqHZmZLl8r6274/pRANSdXMnLB?=
 =?us-ascii?Q?NHDNfyowWe9mlc4CvnLlWSJWUfO8I6NIRE8TIBsL7Upf/AkwEP8QPr5RTwv/?=
 =?us-ascii?Q?8eGdVSlgbPU/bVPsx5KmnbzR3sILj4Fr5cO8mC4GVX8hmaVVsR596e7gxj/c?=
 =?us-ascii?Q?KgcpHiSgZbKg27qqKWQkB0Ecpab/Ft8fU7P2XQTpX3o5DInzu6aKKB6aRzml?=
 =?us-ascii?Q?kD/X7hrtNEOlpb6n199iLSv3uPBh6Y55C7WoxcimJPqT0OA8JuHSDk9tkVAA?=
 =?us-ascii?Q?JavhWoPBOItyxWcbJZXYpsfLhYPrKXnSAvm3t2N0MLAzBvcKKa+I4kO5fhZc?=
 =?us-ascii?Q?FvVeqeCAqFkToChYN8O0Mf++YKlXf4sdM4WDxre/kwd45OULrwJQxOk7XEKi?=
 =?us-ascii?Q?csi+w0m1lnLCNm4N8RBZTjeq0Yt87tKP+nGQq3ZTzQ0wbuDqhbR+Uvs7OgT8?=
 =?us-ascii?Q?slFGGCHaTBta19l8X3wmFq7lH3gl2AkzRu08jue5fJNywCK/18GwGPLya5bc?=
 =?us-ascii?Q?HaYj+0jDDeBRFhQCpvGO7rkvvmvqSfD8aDxYV8D3E21jj2b77ttONxMoIPKc?=
 =?us-ascii?Q?FKi0n0nRtV50nfKfWRsmbI5m2BXLOI1SHcn6kfAOL1SY81AglfCs63HMzifl?=
 =?us-ascii?Q?+a/dHt9RN6+s/YbJ4c+gv5eDnA82eHyIg5UFJ6B1zMhmMfhAdeyFu/qMVBOg?=
 =?us-ascii?Q?38bLo1Ao3KKd49PhrGx1ufx2Tei1RWTjh/t+WtN+FkXAJvSWHIaxU+vIFanX?=
 =?us-ascii?Q?EQzInDvkahG0O7uTSczO9u6v2vpgJk62h6YesNr/LHDfACEbNCXjjfqIOgqa?=
 =?us-ascii?Q?orjXFpIlxI1RACY99FeGxOqDyPGSCVxEHDueZvzcaDWTh4ai+JtnG6d2cEOV?=
 =?us-ascii?Q?MuvXD5veIYISIZCh7FE1kxLi9bGKl7r/OrV8uJa5VZg9Y6dDp2ajJ3sLgADb?=
 =?us-ascii?Q?4H5C2ahj2Pf4725Ja9hzSPOubDXWuo78ML+DzMl4EUMWUrF5BqUUjmHnXv3n?=
 =?us-ascii?Q?bTtZBS1abLRh/YjUvPnazuBVAWbqj8jvgKtHVrQFt0HrnaCN2e2rElQBI3Gn?=
 =?us-ascii?Q?HVFKsu+7oMJPxwpegytP8lFVcLKP2ULUDvyHT9MNI6LvTHKi9AuNyQwvSwqy?=
 =?us-ascii?Q?HGfXo2LfyWkBuZmiPH/lIchTLo8lCQeVjFz+p1YB0FJU1pVbnjfKvPEU3XEc?=
 =?us-ascii?Q?smzSZYkcHmy/L1k3vyAF+EowHWrFNoL12DJwAgOL8zX9zdVDHaL02sj9ZQvk?=
 =?us-ascii?Q?MZRj3Y3ev1enMbGsH02FHuKr4WZPHfepEElzq2LpURsgN3XEX3gb+BX0zEZB?=
 =?us-ascii?Q?9x60UP7JN/WugdmxrMM7TK8JhYocSIL85kPILTpK1pmBWnHX0HtEyYCW4XH6?=
 =?us-ascii?Q?xSYrrFNLqxlDS+s+dxGemJNLr7r0dUJ8pZ3jlwC++gt10pRb/VKUscTbIosJ?=
 =?us-ascii?Q?b8UYzZCdQSWIEMLBNm1nNz/Me51n5iVqLWUtqv1B8suZuDS345miZ4r41fh5?=
 =?us-ascii?Q?Gg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32435b65-f5f5-4ffd-0485-08dbc433fc09
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 17:12:55.3422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iS4VSQ3OcumW9ViywwCBUEWdBq7o/MOmpPywUnRWBaHbaEILQPOl9V+i12s5T7nmZXd+7aGrfq+/YuS2a7kYykqSIrM6BKxCpzqjqNK8C7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3761
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Randy Dunlap <rdunlap@infradead.org> Sent: Friday, September 29, 2023=
 7:33 PM
>=20

Patches for this driver usually use the subject prefix "hv_netvsc: ", not "=
hyperv".
Other than that minor tweak,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

> rndis_filter uses utf8s_to_utf16s() which is provided by setting
> NLS, so select NLS to fix the build error:
>=20
> ERROR: modpost: "utf8s_to_utf16s" [drivers/net/hyperv/hv_netvsc.ko] undef=
ined!
>=20
> Fixes: 1ce09e899d28 ("hyperv: Add support for setting MAC from within gue=
sts")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> ---
>  drivers/net/hyperv/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff -- a/drivers/net/hyperv/Kconfig b/drivers/net/hyperv/Kconfig
> --- a/drivers/net/hyperv/Kconfig
> +++ b/drivers/net/hyperv/Kconfig
> @@ -3,5 +3,6 @@ config HYPERV_NET
>  	tristate "Microsoft Hyper-V virtual network driver"
>  	depends on HYPERV
>  	select UCS2_STRING
> +	select NLS
>  	help
>  	  Select this option to enable the Hyper-V virtual network driver.

