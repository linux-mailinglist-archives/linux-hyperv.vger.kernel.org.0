Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DED22E0B17
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Dec 2020 14:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgLVNql (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Dec 2020 08:46:41 -0500
Received: from mail-mw2nam10on2137.outbound.protection.outlook.com ([40.107.94.137]:58081
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727375AbgLVNqk (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Dec 2020 08:46:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrYCQ9H2md5zgDSQlK+c3ob8qJ0xVNC1FfIF25bz3xCFjJAB/hplZBw4oG7ALyrVVuDlnK/IHJLC3hjkoKFhXORu+bdWLlzu0ythKQdopa6wD2jsoBwwxGejdcCllJko5W6ICE2u/MjXwbvh2Faq8+RX86W+W1T5l6u0Sdh8nluWBSHFCko5Qm2KTFwGuRXtJ3kK1Sg9wRxXeo3wEgQY6mVBLfvvT2CTrRuHpULU5xMh5RZoH3NMdA4Y5kOJVRrRvv8HdrCMl4TAMZgkLKydKLPzvW1cGg2D5fG1b6Wfjfvzw3i+d4mjbTzazbYVejtmoBWk+1kOTgA+h+fQtX4ZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVTI+Di+xVpBYSYkA9Z7MiQ/pIzCQ0RjBmIb6Ks6VPE=;
 b=WXcs964enwUFWgdc+uyxvqNfG/hRiJiLzlrd1GGNebEZTN7mtPH/zGrtsNkARQTeBl4tJsIBeqK082IJCKRi4aOA7bvNs2T7tk+sEGJ57v3ORYhsYQEq4S6kvIWFtbtIVyLk4yTb30fDw8F6luLcN/IRZ6icAxCe7iD9JJz6wGBg5AewJ+LZVUfMXypET6/EDvbGZoNbCX1xs/L9vzF92i2FhszYr8G0X1qYll/4oMK53I0jKmorKc+A2v6V5aXTJu0His7OyFFGIRVqWPEuAfr0741viwFeNLxEY2QQiki00LNiXVAgHTUUMlnPXDGeH5QPqmo/ElGPsnFv+8nhBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVTI+Di+xVpBYSYkA9Z7MiQ/pIzCQ0RjBmIb6Ks6VPE=;
 b=bETidWgckac/uf+Oher4HKt237Va1Rh9ESSlIpdY5jyJm33hntUxPBCUcmURGSDzUsIENEuHi/I1cEn++pr8FeEj1YtXGODGf8sw3aqn8dcL1Sq99vuWZMXvGR4GgEKoWs9cUZd4R2+e+0zLrFq/Wi4zDHgi4pao4iJcSKJL4bE=
Received: from (52.132.149.16) by MW4PR21MB1923.namprd21.prod.outlook.com
 (20.182.11.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.6; Tue, 22 Dec
 2020 13:45:53 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922%8]) with mapi id 15.20.3721.008; Tue, 22 Dec 2020
 13:45:53 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "jwiesner@suse.com" <jwiesner@suse.com>,
        "ohering@suse.com" <ohering@suse.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH v2] x86/hyperv: Fix kexec panic/hang issues
Thread-Topic: [PATCH v2] x86/hyperv: Fix kexec panic/hang issues
Thread-Index: AQHW2C+JeK2pk6EyK0KhohVBANde/KoDIOnw
Date:   Tue, 22 Dec 2020 13:45:52 +0000
Message-ID: <MW2PR2101MB10521D65ABC757B4EA0711CCD7DF9@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201222065541.24312-1-decui@microsoft.com>
In-Reply-To: <20201222065541.24312-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-22T13:45:50Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a2741a92-3529-4372-a39b-3b2d1dc696c7;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad288d19-a18b-46b3-69b0-08d8a67fe677
x-ms-traffictypediagnostic: MW4PR21MB1923:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB1923EE0070E4C2F102AE3DE5D7DF9@MW4PR21MB1923.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PDR24Ikm/dsiQf1holmTAdIotSv3fltX+io49BBE20sgZK2awqJU6tl+xT5W71zLlHDr8YkTe7QbBmIIvgkv4vIGOVkN5BpYZhzgTN+B/Zenb/RS+z0mPBw+K0YTfOjlJHGZtMcej139f+WYexATj8oXSM4mqmVJcWFRe2LyBWOMIc2zuqNSA92+x2ANxYB3w1dJof8g9Na1UjKGyvyX3hLJEHokjeD9OE9uNlD12T/rHIuTYCU1ECrVaFKC1TvmSJKjvmCvI/j+GQoj5tbPplJAJSVszfmrxGjN5MazZZzCw1Agzz6xoedq5XZwkztp7ObJY9pG2lXa6LCn7eD0h1ix3r3ctLZgbfvCtwHH69WWWyaxqfyjA0efoqRStmAxFxT6dXadop83ZWTMoRR1dlYDvP+bzpJ3X90tRSrvQv+9eAtBNM94yG/3pySFQqX3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(52536014)(186003)(478600001)(10290500003)(26005)(82960400001)(8990500004)(66446008)(82950400001)(6506007)(316002)(7416002)(83380400001)(76116006)(110136005)(7696005)(8676002)(5660300002)(86362001)(33656002)(66946007)(4326008)(921005)(2906002)(107886003)(55016002)(9686003)(54906003)(8936002)(64756008)(66476007)(66556008)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?iUslUr9gUB+ABfhPeRoxY4WhzknW1UusY6DYOwoTd+jXhIdDBQKZO+lsCgmR?=
 =?us-ascii?Q?VvsW1oEQox3Nrvjg60OjHDWh09iv3VlnhxMDxzzEsSyytRuHyA5KNG5F1eKx?=
 =?us-ascii?Q?ugm+WmywJ+VYmGJ4XMFOSzYjsr8UyIC4YsgITSqZL/Nl06egZaki/0Y3iG2n?=
 =?us-ascii?Q?8FOTBe1SMpaeUIW2SHt8bgzgcPbfb/nHLe0za2pQ42VFrTA8RyhSPIbiNNya?=
 =?us-ascii?Q?GtGN4a7biWDURDHKTFeFvpZFnpsoFD5IJJUsCni94NOcqVjl87PHeYS2rfSc?=
 =?us-ascii?Q?DWb2078qBmwZpnLH1NYJo1S9bjCR/207E/jIpnI/mwjhdlM7TF8BGTRAej8F?=
 =?us-ascii?Q?vHtxBrXnHrzLx7PLNtiiNlR7ZIFxaZHWRDl9xpcEZVes6QyAoNeRb3krd+HU?=
 =?us-ascii?Q?OP7LWhUEyaJKM2zIpwB9tSlOpKNKf1LdgmQk5SHRQIjK2I7v2QYTlKm6XVpM?=
 =?us-ascii?Q?QHJt0bxU6SvgCg4CcQndxAwMFJfz8I8fQlT5FF3YO8AHGzbw3/3YQdtQ0yuv?=
 =?us-ascii?Q?YEQkWy34huXztzuzRulwsqC+Ys587vlYag/Z9a9gnxW2Sgegn00ytxSEXBov?=
 =?us-ascii?Q?agmut4ZP3f97j9ItKySzunQEuJwLRJJT6cuEhuisr+Z+W55AyFSR95EOLDda?=
 =?us-ascii?Q?b0Yr537kWlXQlLHE/MQNtYiYWThn/orJJUMV5vigTdmoxvYDYSUHaNz6m2if?=
 =?us-ascii?Q?c2mGL74b/a1R9sqvBXzkltuXGnsv/A+qW/Bd2Lsk/iiu4NXkFqJZzb/sTaSV?=
 =?us-ascii?Q?N0UgXkDqjPoMH3j9m1bt+I4XB4d5Dx5cy6bAREDTKzGmiBZqIVcaptNEK5iF?=
 =?us-ascii?Q?KcatzSNUzwADpQ93nLSPgsKOhMBMUv+Vo2gf44CJsyere6lgJXJQu64R2KUE?=
 =?us-ascii?Q?4iHlwC/g/JEKE3k47OYRmHh5r3IESL4fFOdCygRbERP63U039IrtClG/nEth?=
 =?us-ascii?Q?VCrHxOiTzjqvyEL+hrCAIrJnMivCd14zn9u5v+t7Ow0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad288d19-a18b-46b3-69b0-08d8a67fe677
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2020 13:45:52.8629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OwtnmWPrXFZdJFTAh/1OZK+fi32HIp6iwQdkceksfsa/vQNJN2+WpxTWbq832U5dufSDkiltOdHXOHHIPEiI8xoplAPQyNxoqOOhCcgilK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1923
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Monday, December 21, 2020 10:5=
6 PM
>=20
> Currently the kexec kernel can panic or hang due to 2 causes:
>=20
> 1) hv_cpu_die() is not called upon kexec, so the hypervisor corrupts the
> old VP Assist Pages when the kexec kernel runs. The same issue is fixed
> for hibernation in commit 421f090c819d ("x86/hyperv: Suspend/resume the
> VP assist page for hibernation"). Now fix it for kexec.
>=20
> 2) hyperv_cleanup() is called too early. In the kexec path, the other CPU=
s
> are stopped in hv_machine_shutdown() -> native_machine_shutdown(), so
> between hv_kexec_handler() and native_machine_shutdown(), the other CPUs
> can still try to access the hypercall page and cause panic. The workaroun=
d
> "hv_hypercall_pg =3D NULL;" in hyperv_cleanup() is unreliabe. Move
> hyperv_cleanup() to a better place.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> Changes in v2:
> 	Improved the commit log as Michael Kelley suggested.
> 	No change to v1 otherwise.
>=20
>  arch/x86/hyperv/hv_init.c       |  4 ++++
>  arch/x86/include/asm/mshyperv.h |  2 ++
>  arch/x86/kernel/cpu/mshyperv.c  | 18 ++++++++++++++++++
>  drivers/hv/vmbus_drv.c          |  2 --
>  4 files changed, 24 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
