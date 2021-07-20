Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936983CFF55
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 18:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbhGTPpp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 11:45:45 -0400
Received: from mail-dm6nam11on2136.outbound.protection.outlook.com ([40.107.223.136]:47448
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237209AbhGTPkJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 11:40:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+QHUHZGe4t9A8JHTqHAAYXD3ohIq3iyKy0Y8vUbpq9FFMMElostY02m9+0Npt1UqAjCPYU7K0QelKhdIPAWthS1Ch69Xny3Esj7UnV/7bVc6caVVenXY8VG9FTn+Qb+BSn7EvqAStGRDkTQsJRW30rZcV1c26QGDIAwtSQUNkxiRyD4ulzfLLqTi8tVckm9NA5ZJ1xXEZPBcMgYJXZIlU2rCzHWjt1x+a+y4bnpWkBey9QM4rbFsYkWp6kQZLezNejFGC1aYrUdqVzegYYQ/B03HOOuHYvnMOcrx497Ki62qa+Ldgc0SD4fqBpdV2zUf4z1qoyFQomi2R7aZCnS4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AC6d4CfvHja139LGK2l2RFLqX/2NCnFLinmcgdPZVw4=;
 b=TR/1gKY9L+rpvJSmpz9DjkWFNLU1xF0be/jJ4UhwQns+2rl0dzIT1DgLDT7l52s+viamvpEjY8gv6P8xSKXt3dAKkIbwK7uQboLJ/D+1GnWWn/uThiXIBC8Qn4sJ+jhRW9vvjsLUpTL4G64qGKIOkrsp3SN6dRiKUDRNWSPyqs2phw9NM70sGrBYqqclTFv92ya0PDvdVy2WMEJoE0J2bPTWOQqym9hCKviugi4gw2gKlFx1/FFEAqH4ZUhI9Szktn0jHgg4+pUdjLxiumxarirDXGPLatl6EwfleUChcyM93yVMn9cvkhLnX1CFgN1LiBDw52U1YUKswZfrH6/nEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AC6d4CfvHja139LGK2l2RFLqX/2NCnFLinmcgdPZVw4=;
 b=Ith0nByr2PR1KUuFtGYOloOm/+Y0auDutxEiPrvnWJsfpIPYJ25cB6tgnBVYm3V+I7+XjA+LNMilzL9kTBriFOi6zGBBB4pp8HPcImcGuTvKfFPTOMpGYutmW8twEIR1nPuprttFbx4duJZI+UuW6ZZKniJ26NeRTQyMp3ugTrI=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB1020.namprd21.prod.outlook.com (2603:10b6:302:9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.0; Tue, 20 Jul
 2021 16:20:44 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::5913:e360:8759:e0f6]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::5913:e360:8759:e0f6%6]) with mapi id 15.20.4373.005; Tue, 20 Jul 2021
 16:20:44 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "viremana@linux.microsoft.com" <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>
Subject: RE: [PATCH] hyperv: root partition faults writing to VP ASSIST MSR
 PAGE
Thread-Topic: [PATCH] hyperv: root partition faults writing to VP ASSIST MSR
 PAGE
Thread-Index: AQHXfOKuCkOiUQ46GkaTOSxdT1kTAKtLuKKAgAAjIwCAAAKZAIAALFMg
Date:   Tue, 20 Jul 2021 16:20:44 +0000
Message-ID: <MWHPR21MB15938E4E72E1A3EB3744AD53D7E29@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210719185126.3740-1-kumarpraveen@linux.microsoft.com>
 <20210720112011.7nxhiy6iyz4gz3j5@liuwe-devbox-debian-v2>
 <fd70c8e5-f58c-640b-30b7-70c4e4a4861a@linux.microsoft.com>
 <20210720133514.lurmus2lgffcldnq@liuwe-devbox-debian-v2>
In-Reply-To: <20210720133514.lurmus2lgffcldnq@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4f58f013-da4c-4b42-8cf6-19c51bcc2042;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-20T16:13:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d193ae5c-35ae-4416-40a4-08d94b9a5344
x-ms-traffictypediagnostic: MW2PR2101MB1020:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1020D390D4A338614CD10477D7E29@MW2PR2101MB1020.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vw877tvQnqUIFxFpimE8JOSTxuWlx4a8SGrASugZ8bBoUq8Z8fWzr3n4feVBhH9JzsqjX7H856WfLzNRkPcQJDEigf8yjgHcRlfovO7Lc91GycI3RVImsmrlMADUiu8LgWJ5CY8YjAA5GacHlPlpsw65Trp+Ys70WzW/+1klCOUZ6XsLHlQn2UIxyA0hkRYT4dSKWCVKajoutLVHRuLb3mnCKbRKvdsE8+LIT6zprtPdKd5DqFkvvt7KXT3REGfCYFwLDl9V2k/9aBR3Qnoey6GhZjL2yaWtdFgScPseQKU05rIFIR1MgfjzFFoqKQQVXeKtRk/ok2loqrag2YwptMYJL3nWA1IcEILfpLDSypbUVXzHh3Oaj0CrGbbHM65u0P059WmSxhhbVIk4ic1h1Bv1h2OxQVPy08IhUv4UheGMAVP98FipdjrNLxFHdZgIuiX4fxEvjiiHBrztqSd6Bzt1s3nnhW/PC7GhhDVp24Jfmtv37mpvfq0o7FaF+cCWNuNRl3yUMBgch8pNkcdQgKAkySLukrJkJKb9J0Xmcs2CmNxevZUGEj1K59N+looUIqjCL6o1J/SdfhyiMaj+IC/otJ5n51Th2+n0sRXQF6MbV+7NNd4rFxj8Kmx+n0WhNusJgcXCKdAmczbeeYhmB2GFFXAWlsZVoE68KhnCRqOOejO8In5KQ1+EDd7xeuiG7is/PTmfPwEzeo/Gi/mPQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(66476007)(26005)(38100700002)(110136005)(107886003)(54906003)(122000001)(33656002)(316002)(66946007)(83380400001)(66446008)(52536014)(2906002)(82960400001)(9686003)(82950400001)(4326008)(508600001)(6506007)(7696005)(76116006)(10290500003)(86362001)(55016002)(64756008)(5660300002)(8936002)(8676002)(66556008)(4744005)(71200400001)(8990500004)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T+UWSxeKrZbZs+nXptS5F3nn98EAbx1vcnW4ji6o7xoq/erzvXVOddPQEaAX?=
 =?us-ascii?Q?4d+HbFx6x3TojBDRVlxcuitccHDvHgW12gcV+0t0J/BCSWmtRY/L8CU23DWs?=
 =?us-ascii?Q?nxfA1VZYUtlNq4qIaNFnEWfJn50FcNejH1S6gwTABepLb/bMjbopRBR17obg?=
 =?us-ascii?Q?hObjucensdqc5Ijggp0aeK82Y33KOT2K/B8yBUF34M+K7loET5ZaKqnGHc/b?=
 =?us-ascii?Q?tAoLovciRH3dYgVg4NqyPthtzOQXu7xg9oOCQujJi3tdQj/zSPnCf5/yVjMr?=
 =?us-ascii?Q?qJft1epCG7KDHSi1hQz2VXE+ZJJERqp0J6OLJNaKhie0RtPTuHquNa8aSaC5?=
 =?us-ascii?Q?vs/BMR3jRk+wVpfH8WYm5AsyYE+9LTXVDG3JppJjOCaeRRdTD+nIApqZWBUz?=
 =?us-ascii?Q?LCS/A1Gyrbg9Kn4qiSZPkfLSMyETmPgtFXv5wB7T10jiLYGBWvfZROj9AIy3?=
 =?us-ascii?Q?5nPkslAfdMFCNaZi1czyfuASrP1DCOOoP7Jy9ndLHpNIjJ+f25HQhFGX7AHY?=
 =?us-ascii?Q?aMRAmo0uZaaj9AVCznp19NbZaXlCTA5NIqa2k3CeBChiHr7IPvstVRIg7CMa?=
 =?us-ascii?Q?+LTVDyMK9hcBXlWGx+IVD3fLmggg6NibtHoCNRbrVNOU2+6JqjrA4XJNuOPU?=
 =?us-ascii?Q?l86lgJfcBGSubR0+3etVKpOPf+Mm+Uv2ssPVLNJlUkPqwAY0EbXUoT+R30iG?=
 =?us-ascii?Q?IK1zTxDYy7o1Iq8MteSliY2Hzcaagqp9GsicuV60YcDKkTQqWhR+2zKXkjIw?=
 =?us-ascii?Q?RErNknillS2CFKf8xqBAI7aBqTyKRjsIJOa1QvNEas2Co1G1i2hdk6vOiXkS?=
 =?us-ascii?Q?rFIA4Cz2184cLVu5rLNMSd6pX13YT8//UAoB/4j4g89dc2FBVFYn+bRi812L?=
 =?us-ascii?Q?G1f0UpkChiM3Y3XBzot+TOGl2WR4WhycHmZazkbJlTkaU+4oPm3VnlAkjTe4?=
 =?us-ascii?Q?EjJQ1Vp7PNRoqdG3R4RF7lw0VUFNK1it1lDhhAjqaBNil4BpacA//voMXDn0?=
 =?us-ascii?Q?LIuiIzmKKxKLDEqS9flbBibo30xfF4lCA6+V6avYpbe8yiaUHgM8bduxH7Te?=
 =?us-ascii?Q?OrAJdoXlHqjU+R44z3OXXGE3hG6XTFE3Vn9Xvd1ttlVO52VmT9COx19M+4Kf?=
 =?us-ascii?Q?65STU2TMAoWfan8aRuSbP6p6/PnYfocxxcrs/E5wNPcl/g123WElVJ1bmJ/m?=
 =?us-ascii?Q?sIkPYLu18iGbJdxjls++onLv3xfXgT/cYcm/RGZrGlks3tL/Guazyw75BrAm?=
 =?us-ascii?Q?yHRDLGzzCAY2gFduNLLitqgau+wbw4RjKQgQhn5KEMwFAPVwqKJFNooDjYeF?=
 =?us-ascii?Q?RsauIxb7upmqYNSffEkF6Mqv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d193ae5c-35ae-4416-40a4-08d94b9a5344
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2021 16:20:44.2245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zVZF5mKEnBxjOAGxQifZrXdz52Sx0F2Cufg3kb795mJsuy1qk8EkEbThFH6CicHd/6Lud3fXiPkSmPfZbPVcjiG/Y2JOUWdeeJ+hAvJIp94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1020
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Tuesday, July 20, 2021 6:35 AM
>=20
> On Tue, Jul 20, 2021 at 06:55:56PM +0530, Praveen Kumar wrote:
> [...]
> > >
> > >> +	if (hv_root_partition &&
> > >> +	    ms_hyperv.features & HV_MSR_APIC_ACCESS_AVAILABLE) {
> > >
> > > Is HV_MSR_APIC_ACCESS_AVAILABLE a root only flag? Shouldn't non-root
> > > kernel check this too?
> >
> > Yes, you are right. Will update this in v2. thanks.
>=20
> Please split adding this check to its own patch.
>=20
> Ideally one patch only does one thing.
>=20
> Wei.
>=20

I was just looking around in the Hyper-V TLFS, and I didn't see
anywhere that the ability to set up a VP Assist page is dependent
on HV_MSR_APIC_ACCESS_AVAILABLE.  Or did I just miss it?

Maybe the VP Assist page is not useful for the APIC EOI optimization
Purposes if !HV_MSR_APIC_ACCESS_AVAILABLE, but the VP Assist
page has other uses, such as for nested enlightenments.  So I
wonder if the VP Assist page setup really should be gated on
HV_MSR_APIC_ACCESS_AVAILABLE.

Michael
