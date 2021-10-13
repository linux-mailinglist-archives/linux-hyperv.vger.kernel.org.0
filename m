Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485C842CA52
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Oct 2021 21:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhJMTrA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 13 Oct 2021 15:47:00 -0400
Received: from mail-oln040093003001.outbound.protection.outlook.com ([40.93.3.1]:29535
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238337AbhJMTq7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 13 Oct 2021 15:46:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxKr58XV0DOM1E0uQ8ynEGlJUZ5vBvtxDPbS0PT8C6ABGAVN96Nrvonlvbj4ScHPoPKe3H+DNdEJr+81aCmjXLPDrs0eyFkVvte3s7Jz+keWhm723NH6pNkryJf1rf06eKZWGD4zbdttNgpR9Cwj8N34VGzCcEYRC8bjkXN06FGzdr9wHl3C2Xgh9uq5DM4ijrQ0Qc66UlKPq+X+uFmkY9yVIoXXwZ9XjmWmhoaWmBE9UBvVviu7IEiO87UWgWB2IXg3m9WC98K1hjsUnKw6OgWjwfSCTuXlyDuMSxDE5vA9y55xKitt4Uu82+XYNeCbO7IGnLbfGTt68Qo4sQf41A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HdW7A9MbpAJaTFzbH9LQlbbUxwyjbfeSohFDT2DrQE=;
 b=nzor15Pz5K9O8ARnVDAzIPKNFO9Xy3/O9D76BC2Yk/stYvFAT248nZZ1Y5rcChNBkA5A3Fw+BE6MziXJpApyGMKZJVG/dLyH8RKt84vZrGPc0pyeiVNJRGFCXy+aHIbjGkGdTikuleAWJo9fVKIWBpVrvrnpMbLtjaqIyw5H5ltkbSfQvfeqcTFrnWt57kQFqCH1aZ1rox8eia8pBo7ftkKFAjCTE26HbslSJfsDbjBqnp9XjeGm3dKsMtdLwOvtFKC42SWbQZmEkgwYUy6EXedsDqZ1h1zfa98sLG+xkUX0HddtnlicF/nQsDa++iLBrVinYOQ3+a+c0QoupnfLrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HdW7A9MbpAJaTFzbH9LQlbbUxwyjbfeSohFDT2DrQE=;
 b=EkOfTHoBSPrX+QyWZUuIzmpXBsuCKUdQvBnES9UhSP1meos8uucfC+zbFNeK//FpnI139yzg0ZWzfj/GhN8+gnP/kuYSutakvqR0Fx8rqW4geoMPD3h/u/fLGRMwIE+3c1xkgLcUjf6au5TmLVXDc0Xj2AKenA+q/M4wSt4LDlU=
Received: from BN8PR21MB1140.namprd21.prod.outlook.com (2603:10b6:408:72::11)
 by BN6PR21MB0274.namprd21.prod.outlook.com (2603:10b6:404:9b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.4; Wed, 13 Oct
 2021 19:44:52 +0000
Received: from BN8PR21MB1140.namprd21.prod.outlook.com
 ([fe80::f136:50fe:4475:5f17]) by BN8PR21MB1140.namprd21.prod.outlook.com
 ([fe80::f136:50fe:4475:5f17%4]) with mapi id 15.20.4608.016; Wed, 13 Oct 2021
 19:44:52 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Boqun Feng <boqun.feng@gmail.com>
CC:     Marc Zyngier <maz@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?iso-8859-2?Q?=22Krzysztof_Wilczy=F1ski=22?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "\"H. Peter Anvin\"" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Baihua Lu <Baihua.Lu@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2 1/2] PCI: hv: Make the code arch neutral
Thread-Topic: [EXTERNAL] Re: [PATCH v2 1/2] PCI: hv: Make the code arch
 neutral
Thread-Index: Ade8Z/d+RNK9WO8BTSODIa+n2Enr/QDkHtWAABw74OA=
Date:   Wed, 13 Oct 2021 19:44:52 +0000
Message-ID: <BN8PR21MB1140F178549EA2267F3F134DC0B79@BN8PR21MB1140.namprd21.prod.outlook.com>
References: <MW4PR21MB2002C5BFFD9DCB9C3B2AF9E8C0B29@MW4PR21MB2002.namprd21.prod.outlook.com>
 <YWZ3X4K19WS1WNcP@boqun-archlinux>
In-Reply-To: <YWZ3X4K19WS1WNcP@boqun-archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b23cf976-a43b-4c04-8fee-678c95c81770;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-10-13T19:34:48Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e62ff9c4-ca64-4d8a-2574-08d98e81eca3
x-ms-traffictypediagnostic: BN6PR21MB0274:
x-microsoft-antispam-prvs: <BN6PR21MB0274980BBB9E69021A5AF158C0B79@BN6PR21MB0274.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BxFHOm5c7f1FqIQ7ij/PIqf5MG2TRGbxWOx5uAQuqrkY8Seiu2Ud3riZ//fvTopwCbLxiG+KcnHjUPkePojEfZUN9t/1bdBqmaL6ooAp3zB9UaOPUhXAxa4kfVvS9OZ3h/nmUAzMwqhCzb8YF92l+ro+S8VXyWTYpg8CxRGalXrE4yufkGJ+I+49FsPK5770iS1iyRImkSxkw8kshvjl5aUv+BWwsB0JUUsGNuu8c60Np2o64RjiHMpustLM/cIVQgBbyPzINuu+X5Czl/gP7DxN9V8UyzSkKDN33cTJIJDfthXq0LPjpnLbkLrJv+cNL9x8Sb44XLxZpVi182LYsarSx+2EBKVzQcOdg5es8IYwgn4NwFNjx+d9Q+B4JWi/GPBomfCka/6P0NZ9M19r0hnmxf5M8KRhUEH+memzTQpLZrh3CCsAyTB3CASpmoao49DGXigV5Gxt4TLQ4ycppJOJe5xQOZrAj9902rHt9dGtF90VY7OcEviIX0GBFCjM9OHNaWyMqrP5dmsT5bw72vOW+hO3Jf7NF5xo3kJnJcyrtlH0cQ/ahOtSRhUmsd+J7iWO7kQ/4oe0E1rhGPH2cqR2RGRRAPo4nKj52Qga33ArS7LBygahLiZw4VvhpOt5e+Yhf333NmgoXCZZ9nGw4vccRdUCR9am0QNP3zwxzFMBt0TLiIynfnq30VL91ec+gY0XzsjoRXXdUVF/vCYd8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1140.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8990500004)(6916009)(64756008)(66556008)(66446008)(66946007)(66476007)(55016002)(76116006)(54906003)(508600001)(4326008)(38070700005)(5660300002)(8676002)(9686003)(4744005)(7696005)(122000001)(38100700002)(86362001)(71200400001)(186003)(52536014)(82960400001)(7416002)(82950400001)(10290500003)(8936002)(33656002)(107886003)(53546011)(6506007)(316002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?xJq0Y05t2qJ4vzIel1UDoABawAM1jFPN7Rs+KF9+D4aiC42uf2X36fZDSe?=
 =?iso-8859-2?Q?NADQbq7tWfYaLiRpSyW31+qtXHGG2m88K/ttiho80K9OZZhaPepmDkbRXK?=
 =?iso-8859-2?Q?yQ4Mx71Fpp+8R+n969K9e7XawD84aZmkCV66CC8B/2R5+fqSBVjLdhcH4o?=
 =?iso-8859-2?Q?YVMSYajoNdMyiT9d5ClcxgaDjjcw+mDEyizKtJ1VkRnPF1a8Cl9WiCQgVu?=
 =?iso-8859-2?Q?JzYixPlIz6zbbkH6DBYdOLMC0QqrXZPwTe6UGrtqoWYen/CBqshthm0rw/?=
 =?iso-8859-2?Q?LyXeZajhwBXAi9Ql8cn9gQPzpCeTXH51NJUZSAx6az/HaYITDO/6jdlTDI?=
 =?iso-8859-2?Q?gFbV0iEmby/ao/iytgjtuFC16pHcPzauafM+cGpslSc7w1wmpon9CSgpW9?=
 =?iso-8859-2?Q?L5HgsatO+JF6SXrKeWaD93CdO1M31/f2nHh3kmQVvzeXHQEpHeUTNjvcfF?=
 =?iso-8859-2?Q?QGoCh2YfuzsmDYXR7Hpqfwwu5A2OvAlI3NyYSG1xGCQWNKbv8R2PBPU6Ov?=
 =?iso-8859-2?Q?GdFRNYpbUPeEPzH8WAIDFqoMz1bvE2+318cHBMMDTyZk1GPDWijKa0LZCz?=
 =?iso-8859-2?Q?x/I4/SNhPFBHTqDoQ/3DF4TV4V2VOoXUinEGDfyXYAOTqNqenqe0Bj/2OZ?=
 =?iso-8859-2?Q?JyuAiRpITiCCS25719fPjGp4SWVDdIdAeSlJe+N8myUf098R+HNcpjJaB8?=
 =?iso-8859-2?Q?Cm4bJSRv3UyXl7ssQ7DLl9Tl2cY9Y/Kf7zp9hk/rqNY1g9/7bB7bXx+W/L?=
 =?iso-8859-2?Q?cWpC+55T/wxnLJGcQ9oHIiinPpdG3AcNGJZL9fRMPiLl3qwDR5UbvV2i45?=
 =?iso-8859-2?Q?Df3qZYRxD2CCQu3kQXvZQxGMsSYd4nXLIdkVJ48qZ8lIFwNTdy8hHbeUWJ?=
 =?iso-8859-2?Q?Ah+HZHzV7yajgWXrN6YII14MstB+eVNUO7KKjFgXVvx8WCZ/xMhgZF1S5w?=
 =?iso-8859-2?Q?WHJtqapHNbxvGkUtrdA6qUYeLRBca04a68C5C33PhY5f2fkupSsO0HiTX2?=
 =?iso-8859-2?Q?UpGBlO85os2u6dHJw+uvqS0lORM6Kj8ZjTx32KM7WptfPH2H4VVXtDvYuH?=
 =?iso-8859-2?Q?DbXWp3Zsw9dfc1fSqwALPif0aC7DXfn7KnvEsOjQayyYDjrVoazKl+ona2?=
 =?iso-8859-2?Q?L0zWW7YzLYSCrT36M5Cfaa+JC7F7xTr146mgXrt5U7aEtW3iYakKLTZRwM?=
 =?iso-8859-2?Q?VhFp5bA77MJrmnw0jClSynuyJHOlkbwBlhH0ssFtrSEfQc38ZhfPAouZyC?=
 =?iso-8859-2?Q?4mRTEaTtzh1g9jU4EAc6mBSWCBXibtbP8TVDrfZ/nQKwhlPeigTYVIsHsf?=
 =?iso-8859-2?Q?EtyZcim3yJfjr8D4mKcldi8wejpH8Lhpz+K50LGNy012EtGJsx9YXjwq2v?=
 =?iso-8859-2?Q?ITWRlKF4ryCgQcM0IixCx0/JIbMZXIyfrY9RR0DBKnFJJvN2Qo2lUH96Vt?=
 =?iso-8859-2?Q?41L2kh7ZOD+NoiyvYKBK8uRDe/ifnt/AGgBSWhsKl5fAAZ4SfrU2aVGdrY?=
 =?iso-8859-2?Q?TLFHEWCpUDX3CP1AijCVKdYtysCsuEjQsqyYTedAOsAsZKMVFDtNWopMVk?=
 =?iso-8859-2?Q?l6C63aUmQKflrW951FmBjmA4GzFye8RIKc7P29qkRPhXNQ69d9KlwaFDE5?=
 =?iso-8859-2?Q?/agTWyxpa96qiE/CcWe0dSXxbIdVBrbW6GbrsG+Topos6DN6C56QFHXGi2?=
 =?iso-8859-2?Q?0VGtKtcgVG05yc2IAurdp9DgMHIYs5TtBhXIDZB8XxG6eYcIAO9wwh0xAU?=
 =?iso-8859-2?Q?9KRhOwHaoG8JsVUvbrHLTRKrCGfa7fQUo8hwQI44p1t9a5ZlZh+dEV6A2y?=
 =?iso-8859-2?Q?4LKlo3At5g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR21MB1140.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62ff9c4-ca64-4d8a-2574-08d98e81eca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 19:44:52.0406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kAxbWgmgJV/WpnTLm8RWo77uWiXpIr/o4a6QF9JjUBqCKUTtEuhhOr+FDztiQwoenPDRWyXt+a1v9r/QjG7B2T2srLxfUFgdn4g36nHnoRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0274
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tuesday, October 12, 2021 11:06 PM,
Boqun Feng <boqun.feng@gmail.com> wrote:

> As reported by Baihua (I can also reproduce), compile errors are hit
> when compiling with CONFIG_PCI_HYPERV=3Dm:
>=20
> ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pci-
> hyperv-irqchip.o
> ERROR: modpost: "hv_msi_prepare" [drivers/pci/controller/pci-hyperv.ko]
> undefined!
> ERROR: modpost: "hv_pci_irqchip_init" [drivers/pci/controller/pci-hyperv.=
ko]
> undefined!
> ERROR: modpost: "hv_pci_irqchip_free" [drivers/pci/controller/pci-hyperv.=
ko]
> undefined!
> ERROR: modpost: "hv_msi_get_int_vector" [drivers/pci/controller/pci-
> hyperv.ko] undefined!
> ERROR: modpost: "hv_set_msi_entry_from_desc" [drivers/pci/controller/pci-
> hyperv.ko] undefined!
>=20
> It means that we MODULE_LICENSE() should be added in
> pci-hyperv-irqchip.c, also these symbols should be exported.
>=20
Thanks for catching this. Will fix in v3.

- Sunil
