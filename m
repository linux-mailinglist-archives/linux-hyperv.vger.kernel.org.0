Return-Path: <linux-hyperv+bounces-650-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 641F27DC279
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Oct 2023 23:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FE9BB20CAC
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Oct 2023 22:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11511D6BE;
	Mon, 30 Oct 2023 22:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="N61jxrex"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050EB23C3;
	Mon, 30 Oct 2023 22:29:12 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020002.outbound.protection.outlook.com [52.101.56.2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF04DE8;
	Mon, 30 Oct 2023 15:29:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mxh5zKI983qz4zQc2D6Id685MnahmwWe18H6m4B0FdodpgVPcj0tDymwzNO1CQ7b+Ftp/XQ+BE5VtHZsp1V61l5HzAoZ2Ntd48y5qa3B4357bVAmJ1ln7z53dBrcwK86cGAm2F1SROPmtpkuLjQxMF9liAINbyp7rpp7wwjED6npjhLU6vMkrR6dMqBHReoSlviuFKPWAXJoxX3bcYPAY0ONxDh2irF4s5JOkg4uKMjnKOEuv7mPkONsY+MtFcwDyE9+H9rEH0uQMjv/BXZV4AVZnMajvdQCqrVGwKmk2qXwxvL7VvqEBRaCK9l46dEPVweGTqXiFJEAUxKFpY09sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Idnz/3qzYthj3Ss4s72LTYAIXo4Q+CuaML6Bh5MoU74=;
 b=CwG+HdOQuj1dcA/y96YQvj02cbmDe1A4VIFpsC09adIIZ2prK4xFROzlkHvWyafMX2et3+mjRdn0tWevuowj/QU2n3dxLLek6FZJu+ji/zfJdsFfprl0rZbpEWpU7O6cKosvGi7/whOrdGA4Frf19QyGe6/nZPHaVtWbJb5ejgjTH0GfNWY0I7cVmo/8WBM/saV6BatdTXLzH6kxtxn41JwQ+pHEaPjatrVHATDv1wPp0lRd8dpwLNsPx9hHU0/43qMwmtxpZRipjvk9SYJNLhII6qEJseMTHFEgPce9rcCskXani91xawln9uu+RGJItyBe3YZVz7F1WNqDuxIrsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Idnz/3qzYthj3Ss4s72LTYAIXo4Q+CuaML6Bh5MoU74=;
 b=N61jxrexayjVZ5nh8jHG0Hii3YydSn6jOkadR4CLR3qFqHN/OFdWKveMsDpke5IYGJEFe82bB28kjF2rkwNfdRYxk1e/8JBOqrIo3f0232LpSp6fBm1WLboTr8p+KsV/HeMoEoYn1QWlH1mUQkbHEDcqNuHwEbSx2IXeVm4naLc=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by CO1PR21MB1315.namprd21.prod.outlook.com (2603:10b6:303:152::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.2; Mon, 30 Oct
 2023 22:29:05 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::1613:7751:b462:fb3f]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::1613:7751:b462:fb3f%6]) with mapi id 15.20.6977.000; Mon, 30 Oct 2023
 22:29:04 +0000
From: Long Li <longli@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Patch v2] hv_netvsc: Mark VF as slave before exposing it to
 user-mode
Thread-Topic: [Patch v2] hv_netvsc: Mark VF as slave before exposing it to
 user-mode
Thread-Index: AQHaCRiSNRG1yvvd4UWGUKbgbSduNLBi3RQAgAAJr+A=
Date: Mon, 30 Oct 2023 22:29:02 +0000
Message-ID:
 <PH7PR21MB32639C8A7EE6431FF990B5F1CEA1A@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1698440390-13719-1-git-send-email-longli@linuxonhyperv.com>
 <20231030142542.6640190b@kernel.org>
In-Reply-To: <20231030142542.6640190b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=449f00c8-5ecf-445d-895d-1830ee9906ab;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-30T22:00:22Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|CO1PR21MB1315:EE_
x-ms-office365-filtering-correlation-id: 040cfd24-b9ea-4530-3e66-08dbd9979eb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WIZAM7vuN7dmWg02znfv1HEqiIliUKK8n82SGCfcC9yoB+gnp99bwIY3V7m6ywlBX3B4YdbITXSDT1u1MI7INYWcyoAM+8rML6e4icAjQD/4BSKyM3udDnpNLd8V2s69sfZsPrAVS67lmQAc8ay+t+d1j3+KogVXeRw9mWZEbhRBMcyfD2sjPFzlo0/TvQ67ljdEZK84jwpJ8q+VLN4uvkK3zStx3MabmVtEqGCrMd8q1u4xgKWs4YkoDd5YiVMCduEDsBJmrppSUshZYtRy/Nqi27Wyv7vMcaYc11Sld7ABz0L8PZzNpGHw1qXrmpRtuHYTM7AFXR08sdZSH1QFBXpMvXbuVTe3iiJW64eFxpUUhcE8+kV3FCJWBWYsfi8t7D2r8/qv9hXcXIyoVwUg3+xg1MC9jh1W34n6+UNcUd8kWrPna737lh7h+0u9xfU06lWNRccPJDK1SF675JAiFhVcaVEkjnkIhyBtZuvmHrk4aHKekvhLCvuJyudbsuw9CvfjVpjPNSVZ6sXiKG0bNOPM/YamlIe247pDW3pYDKlIBCwhQPZ5+tWSgHZQI0fyqZzSarvuCuwSbKqvLugarewz4lfM3LbJVYzCzU4+mcpQEL8Mgm6fd5Jnk8EHpLQ+I+JqcXJ3iEt6jD9hsm5vUK2SKm0Yfx6tGxYesCGL+XU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(55016003)(9686003)(71200400001)(83380400001)(478600001)(10290500003)(6506007)(7696005)(33656002)(86362001)(122000001)(38100700002)(82950400001)(82960400001)(5660300002)(8990500004)(66556008)(66476007)(316002)(66946007)(66446008)(64756008)(54906003)(41300700001)(2906002)(52536014)(110136005)(76116006)(4326008)(8936002)(38070700009)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?P5cOmz7tdKvIHYirx/oUL5iZFk+eGPHfJ2tqa4l/UNR/7LBH+t497RG/iNvv?=
 =?us-ascii?Q?RYxIku3zeD0jkhqFGyJ6fXsa16KaXF7GzZ5uUqZpIFwtZvqvNRwEUT67x0cx?=
 =?us-ascii?Q?6463wBtv8xLnBv4s6WI6UPvGRTIe6tpswSiixDEAKBM+izdnOfW5LNIwQf/J?=
 =?us-ascii?Q?pR8ecmrrpQCwR6E7sZ2ktY3Q7bKxs7nGirYJvZXTp/r3KohqIhjmBiovoXsa?=
 =?us-ascii?Q?YwHlGtAENDQ9nKIsGxKHC7G8jzsqCwq5MkX/c+rLR5N9+utwmTmTsImIIrbm?=
 =?us-ascii?Q?81C2MuesihlLXMhdHmdkjhvZMa02v7R/TEoK5AdaAJVl77IrHkui/+CrTDEP?=
 =?us-ascii?Q?JhQVbBIUsszze0rAXSYWEWgA9nuvlm4yk4zZVDM8zI8mDIj3MId0OQF9WoYm?=
 =?us-ascii?Q?uidDR6og3Q6RvjmBLMIYrUB+SbXQFz3K5Ofs/qFWMQVbkiLrHZaHVhmiJ5Mp?=
 =?us-ascii?Q?AbMyrPX/9EhA9xF4cVtEC3jpIAmT9z8OVm7+DFaI6GnX5lSP58Yiicfm9Gzn?=
 =?us-ascii?Q?xXzn07Qt6robsb353zDK8qC5MylpRpIGWemNA7VrgyHyNTfRyK2hOFoqZHHJ?=
 =?us-ascii?Q?LecriQ4RBsyEWvc0EWyGA/PrsuTdzJG+cbFXdC6qv/PbR13GGaBIo2yH/95P?=
 =?us-ascii?Q?uyhl1jW2wHBuD8b/DkL4xU+9kt3/SM1iV/YkHxwh3cmHt0BvLQzGJviF1lwT?=
 =?us-ascii?Q?WwOQP2bwpQO2RO5INOAWtFTt4c44sARXvUlyTUA+UJ68JqmFNtnHY9PrR5/i?=
 =?us-ascii?Q?enzbJd0liMsXZ5ke82lzkyqdbwBmplywiBx/NK4BJwfJI7w+TL5ypSnQz+gk?=
 =?us-ascii?Q?+6FZx0HK0XtX9R/e6wrteOBAFnmN6q5pSdJ2aJmIUpUCVZepWkayWI8Gmv4c?=
 =?us-ascii?Q?63mOH54CQdxH9Hq8wFhouWxudBscnxJfwaFkDdr/6nadcm7CrqlYJgQD5+Q5?=
 =?us-ascii?Q?6tpzqU/bCPVsPwaFokGuzgzQO4DOEAUmPeRuYK+SoSDGuA5K22vxwQavkWol?=
 =?us-ascii?Q?6q1eveW02wvhC5QHocXXWqNf9CQPy86mfDHPP6N1E4cKjtdQqaTz9B2yb0fK?=
 =?us-ascii?Q?lPo8i0mwZQmWt4Ms2657RTKDFql3jpsuWaCTGvdb19UXbN29WLdrqoxXQBaM?=
 =?us-ascii?Q?d9eZpAg67y/6MCxX8xBuobcaRb14YgpM9JHp931f95OusLHwvTrRJDmLrtmK?=
 =?us-ascii?Q?QtkLNe2JBYHEFaSbPgY+dlSi/SjDp3PU7MBObRQw7oUcSZW7J9o810lvEXgO?=
 =?us-ascii?Q?uHGxsEVCEHMa4gVY/M2Tr7MsZSI0fvG/ru3WiMBUYbcC0cNKHAuIr4+iP6i9?=
 =?us-ascii?Q?39/hR2T/p6oq1WBkGDchi56C/cKKyN9O8EfAn8tqeXqoXOT8ehCRzSXJumEk?=
 =?us-ascii?Q?seYBFgJKjmqz9SOxCeVC4UVQuCyTkUPXNmCupU6e3/zjSc/UbrITUoYw4r4t?=
 =?us-ascii?Q?DJxvCr7pxNVIAKzR2IEzqtwipSMfoJADDQXi+FH2c6rtyiapkbnKfHJFIctc?=
 =?us-ascii?Q?HeqPQVI3CEZ3YJMD5/tyJrqKYxUfDFNH11PQ4SHvke3b35n9hra7T9uQA3K/?=
 =?us-ascii?Q?WqABn7r7KQ25yP6S3anEfjbE17WVJmgXhJ4Apa+gdstLjLXCSXQu0KHroyAe?=
 =?us-ascii?Q?6rtXJ9LRjOmkjnNg9GZx3Am8UWP1SPX5bzcDBeZx480M?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 040cfd24-b9ea-4530-3e66-08dbd9979eb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 22:29:02.8668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eMm85qXrIBsMZrDzJPl6UscHT7EysMe9RHKVpGPColXK2TzPou1no5jUM/W2reHmeqhXCj6IQlqeedqIbxlyTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR21MB1315

> Subject: Re: [Patch v2] hv_netvsc: Mark VF as slave before exposing it to=
 user-
> mode
>=20
> On Fri, 27 Oct 2023 13:59:50 -0700 longli@linuxonhyperv.com wrote:
> > When a VF is being exposed form the kernel, it should be marked as "sla=
ve"
> > before exposing to the user-mode. The VF is not usable without netvsc
> > running as master. The user-mode should never see a VF without the "sla=
ve"
> flag.
> >
> > This commit moves the code of setting the slave flag to the time
> > before VF is exposed to user-mode.
>=20
> Can you give a real example in the commit message of a flow in user space
> which would get confused by seeing the VF netdev without IFF_SLAVE?

A user-mode program may see the VF netdev show up without SLAVE flag before=
 seeing the NETVSC netdev. It may try to configure the VF before it will be=
 bonded to a NETVSC.

With the IFF_SLAVE correctly set at the time of VF showing up to the user-m=
ode, it can rely on this flag to decide if this device should be ignored. (=
without implementing some timeout logic to detect a potential NETVSC device=
 that may show up later)

>=20
> You're only moving setting IFF_SLAVE but not linking the master, is there=
 no
> code which would assume that if SLAVE is set there is a master?

The same (taking IFF_SLAVE without linking to master) is done in the origin=
al code before VF is joined, but it was for another purpose. I think there =
is a gap between when the VF is acted upon by other parts of the system and=
 when it's bonded.=20

