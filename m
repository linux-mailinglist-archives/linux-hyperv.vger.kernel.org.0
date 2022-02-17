Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCFF4BA5FC
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Feb 2022 17:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243279AbiBQQbc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Feb 2022 11:31:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241988AbiBQQb0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Feb 2022 11:31:26 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020018.outbound.protection.outlook.com [52.101.61.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006101B8FC4;
        Thu, 17 Feb 2022 08:31:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xp6WmgCov+awzE60vmhb2gBTC1xUOTsADq+Ah6TuowcQYVYPMKVGn33yS7cgmuuzQMU/Qqv9ztNbnCw7nqNe+zHrENU+O+B9+2ZDM85Zun83mZubcNtmLrqBO+q4QPGzj6J24MiVs0yw3VPyzgedr3LZ1mLdKXMYceQGfJuiQ2UaoaViwMlk5tsfFqB9mj4+DtyAFOAtYu4aevgXwQIVMQfjk55fPRow1WGqYAsg+On5CrU1/I1h1kgpGII2kVyCqgYNOHt7xg7ANHfZoLkEU/XG8PtJ05nZlQtPWbV1CJGNcCmeGilRIKCbP8M0lvBXIKR0uU6GYQeP7BlJKrr3/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niHaUGbF/u2h6/sKFuKMndxkP3L0H1QlUim0D2jWTmI=;
 b=Q2gko82YOGNPGyJbsqNY3nrpkEWPpnEliGOGJEOke11nGidHKr3b4tUdoz524vkttlaiDTG9X6aK7uVC09MmXMGFDimD3ymGgsXRJ7goU24ansGuCvOFWa5MrZOU6GxEIUgZ1yzPoXq64R8igHA/KoqwbRbmzTJgHfziHD2spHt7FP8OWN8C7Ge2j4Dv8k8Sua4ZmeDB+PnDpjpWZz3s+LDJsyamsQN1o5xl1IxC1MgF6UV6HkG5+itjGbB7om7FKQTwKoaNMGFpWdUiEDIOPlMIbI1zVPzNhQOnlSZMHW9QKxJDw0X3l6DAxfUAa/BoX+wrTAur0EtsLeA27h3SFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niHaUGbF/u2h6/sKFuKMndxkP3L0H1QlUim0D2jWTmI=;
 b=PYDLgd2Y+TJWz+7dGb1wE4GG4/DTz+bJSU2aoVCUpAsRPl+BCwLL36SxnX9KGA7F825U8v3sDELHW/fk0KKQErGJ/i4AoMuBEmxy9BLHaTTk+aBiJbFF24a5T0oDouxqGmMYmdRaQ3tUJqxfM8NoLUcFFsE+edumIwH7TIXQRcM=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB1833.namprd21.prod.outlook.com (2603:10b6:302:8::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.7; Thu, 17 Feb
 2022 16:31:06 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::ad12:1420:5435:34e4]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::ad12:1420:5435:34e4%5]) with mapi id 15.20.5017.009; Thu, 17 Feb 2022
 16:31:06 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Boqun Feng <boqun.feng@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wei Liu <wei.liu@kernel.org>
CC:     Sunil Muthuswamy <sunilmut@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Rob Herring <robh@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v2] PCI: hv: Avoid the retarget interrupt hypercall in
 irq_unmask() on ARM64
Thread-Topic: [RFC PATCH v2] PCI: hv: Avoid the retarget interrupt hypercall
 in irq_unmask() on ARM64
Thread-Index: AQHYI7D6XgWM06oOwkGkqfFHgzPdiKyX79sw
Date:   Thu, 17 Feb 2022 16:31:06 +0000
Message-ID: <MWHPR21MB1593A265118977A57FF3B329D7369@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20220217034525.1687678-1-boqun.feng@gmail.com>
In-Reply-To: <20220217034525.1687678-1-boqun.feng@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0d0f789c-7683-40ca-89ac-e1281906cbf6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-02-17T16:30:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2676352-6a39-4355-2f8d-08d9f232e581
x-ms-traffictypediagnostic: MW2PR2101MB1833:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <MW2PR2101MB1833E274AB387DF6703A7563D7369@MW2PR2101MB1833.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jYi83PT35Ho3yWFYuXz/0YZn8eqG9/bX6IMweP2RkhaTrHT3C/dsG2MJAHYuId7zWiHbkCn/HQsYoGYs6NDLxxjNeuqbh/iKUX5V7BCnEMkJ2CCC0PYL6e4zfnAXG5EEEg6mmebzGSb9KMZrtgGw2JbjUeViSbGX/C566+l42XFksFzf1vYuHCTxPLovQ0MbN0OHEu/XuaQYiN27a5EExkZssEG2a/JV3PhCwCNQig1esXhvkKKMiGxRQ40a1ypG3BBnvIv9pX5n1qNK6oCTPUHuyokrR2YB2eLYPR+CwPBX3y0BgOFoPmzi3N76g5fxz6SG2oW+S1ygYO5CM9MC2+CmErr1pYMT3C1fnRyspqxAvpIekl1K/jjo74OMDty5nvLP7JnoYBZ4oA6tFlUaJHWy6wIwKv94h5f6TA8oeUBG2G3ABCG4z5P30HSi6hym8aN1QgQyRzXAtS4EX626J57F8LU6kleKk8RfEf4oNBy+TpicZFuQmpjCj9Mkmp1nZlSxPn7ReSgN676l8Sfia2A6H38ztyY99lqFv0nxbgRPolEejdTk+YmI/HLIUs1B2DDy/9vC1BjXvOQXjyZvlI8W5mj2P3P9K+0C729j0w/l7AcY66vFvXsZnkuHDNuP/X6KMZo9DpYOkR4F9n3c5pz5XFjl8UKRkX9L4tiAPMuNruam87Oi/U+dwlD4oSrFPQAqXG5QDFw4cdZWq+9BXiqeqwbWfQurN0tRdLGSg8oEfSxpRAqgFoFxM7Ziwz3a
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(55016003)(186003)(6506007)(9686003)(26005)(508600001)(122000001)(110136005)(2906002)(5660300002)(52536014)(82950400001)(54906003)(66946007)(71200400001)(33656002)(38100700002)(4744005)(10290500003)(66446008)(38070700005)(64756008)(83380400001)(316002)(66476007)(8936002)(4326008)(7696005)(8676002)(86362001)(8990500004)(82960400001)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?unMZg/3z1nhlkTwriMpKgQ+WFbKEqpU7Ymtdc3pxqUiBXY8XCYUNjVAX1S?=
 =?iso-8859-2?Q?Sa83zAXEC5rCcMokkEQzFgSJEYWJ47mya/g7cV3O6SaKpM9dLM7369prNT?=
 =?iso-8859-2?Q?IYJQFfOkQ9vUN4AT9/g1MLUFAEOpHTe6ph/NcjenzJ4GYKW/AhfYaQc+TZ?=
 =?iso-8859-2?Q?f05ubaqENIHRt5ZE5z2+Tm+HVS0+Zma85PbF6L6Lh17V7ZA3uZDpZpMWuw?=
 =?iso-8859-2?Q?zP7XGiAfedqJZqqZ3RT4GssloVXIlQRbLiiJ/eUvZkvjHZ1/1jQXaAxI/T?=
 =?iso-8859-2?Q?0nKRmhvTg2IZL47/IBYj3fPNTaun80ZcGxM3ljhkPw9sNCLGogjdFFhUnM?=
 =?iso-8859-2?Q?ayMNGnVAmtkIAZ49VUClS7e+QFBViRDqF3O5CRP/Qz3nx7KR5KVqe5ZAj4?=
 =?iso-8859-2?Q?AHeND9yahOehLN6R1zh0uExPLPDBkRBEdzU+754bz39sYdEWx8nlKKn4UH?=
 =?iso-8859-2?Q?FtY1cQeyNn1EyNP7RuCthc2LadsiP+rbzTSd8k1q9tQpT/CVGV2j6HNdCq?=
 =?iso-8859-2?Q?aSRKqpHgiLVhU0YMqyMs1T1bg4JLYl7cnIpflRvDYzCzqe+q9pFHzkF/uv?=
 =?iso-8859-2?Q?RJqFjj2R16MLe9f7uMSqSQa3+KOZ9h6TXeztkIf8GVT+LLr4qH7i9MjntS?=
 =?iso-8859-2?Q?MfqXU5fyPYxcMs9qjmW62DsZynXOEEzbTiYlI/tHZSVfTudwoLf3mv0jqo?=
 =?iso-8859-2?Q?ZBjwcwB1c603AHyPMIH1Clho/udgeMEdb2yu15gN/A9phyQ2hJys/aOdGZ?=
 =?iso-8859-2?Q?6SNYdr+zShPNO8Byy4zFRFycxSt5T5PByKM1xStMR7oMI8Yyg7q211ttwr?=
 =?iso-8859-2?Q?cy5TfKFfTYyUFhYTZR/XcW0FFfy8pB1NAqO26gAdizUdr5iAFKqzQbozWO?=
 =?iso-8859-2?Q?IzM+kOB//HUAwUU1YwJkgYwC/PbB5Fv3rHP3u5NAlVMCq9AXD/odKF2Ifv?=
 =?iso-8859-2?Q?lUjiJjxMYntBx6HEwKrthuUccsKQoeJiwjN1rsf7aQ6d2Ti+t7HBz586zx?=
 =?iso-8859-2?Q?3zULgHjPpIx+LwHKUsd3UOUnVp57MmUz8LhO+lcFh/olQqieqoa4rqGi9P?=
 =?iso-8859-2?Q?K7RubffPOLS8L+ixV7bbHvqOKHgSU1mVcBRK6XuVKpkiDxpU8mvvDw5TkA?=
 =?iso-8859-2?Q?PTz7/tUR/v6d1EfsJep5ikF223hLJOyZSE2vbFv6DcDQYTb0Ojni2aJdjj?=
 =?iso-8859-2?Q?GTuWdb48ZjCHEgbbKd/9WQ1Nk/iOeQjy3fSaiv97NRlgRewGIEUstTeTAw?=
 =?iso-8859-2?Q?t7pNUjuGJ36x2FXAk5Bzs6XNLh6s11m0NoNr679y6yVgak5q97S/VuvQR9?=
 =?iso-8859-2?Q?w8/9xtTgbaMY5cRyF/YOo59VjQ+hazrlVdz46JJmBLiIzhqRuYO6uog035?=
 =?iso-8859-2?Q?5+8WcxY1MayhfJYYRlDTgkqbkfHvGcBPvjsu2XyfImcWDuPUJyV8M2x6UW?=
 =?iso-8859-2?Q?KZJCDGR6Ot63/oQMjVjmVG61ZmeHFRgmrxB1xbp110FvzT/+cQa/xPFlxJ?=
 =?iso-8859-2?Q?a7j/r7fUpzh8KIGJXW06gQ3NVDh94YFBQdRL2m/YmEuOKCr5RMU+yN6O3r?=
 =?iso-8859-2?Q?sKLMt+Qcng7fgOGKl7kPSpkHBzYuPyzocLvCRHSBg1v57Zc7fJi9QlI/Zb?=
 =?iso-8859-2?Q?+KV2iepUK16A96hDci1NVK2A1xrHgWLbvRmg/XQtbInFNAew0x7XdUezvS?=
 =?iso-8859-2?Q?mNkSshtoxk1ueH7G4QI3AX+Iw9FGu6uHp+8BH1LiAjmE+89t8DlwaCmEIA?=
 =?iso-8859-2?Q?kkNA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2676352-6a39-4355-2f8d-08d9f232e581
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 16:31:06.0571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OaUGNW6ZXyuVZFCkbOtvqAi7bm2mk+9EeG7IM6BkLV0Hij/Fb3jyXM3JZ7DIFFQj0fpySb9Zsh7P3ai0TL5dbPfCqBdmB7uBbT24gBMzowc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1833
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com> Sent: Wednesday, February 16, 2022 =
7:45 PM
>=20
> On ARM64 Hyper-V guests, SPIs are used for the interrupts of virtual PCI
> devices, and SPIs can be managed directly via GICD registers. Therefore
> the retarget interrupt hypercall is not needed on ARM64.
>=20
> An arch-specific interface hv_arch_irq_unmask() is introduced to handle
> the architecture level differences on this. For x86, the behavior
> remains unchanged, while for ARM64 no hypercall is invoked when
> unmasking an irq for virtual PCI devices.
>=20
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
> v1 -> v2:
>=20
> *	Introduce arch-specific interface hv_arch_irq_unmask() as
> 	suggested by Bjorn
>=20
>  drivers/pci/controller/pci-hyperv.c | 233 +++++++++++++++-------------
>  1 file changed, 122 insertions(+), 111 deletions(-)

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
