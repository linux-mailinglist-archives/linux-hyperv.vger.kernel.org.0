Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A646427173
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Oct 2021 21:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhJHTf3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Oct 2021 15:35:29 -0400
Received: from mail-oln040093003012.outbound.protection.outlook.com ([40.93.3.12]:24143
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231316AbhJHTf1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Oct 2021 15:35:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxQzSMkba7A0bP4MwopfRPz+OrOaOrLLUqt/2/AdjXTyw4CWuu26fS6MHQBUyCgK7CNqmlV9j4uxomCPcyHT05t0lG6Z9IyJibqWr0oIau7bUk2ZlVZ+6SBRoepmctctl8v5jEdjD/TrmCXQNsTXU7OjmlKCvJuZ5AzSfXM7R9ZAJRs5PasH59+esmfKwWiG3oWb5Ahz9f0W0K08F1VAol4UumqQ5Q2Io1aW8/3hyW+b9rwljOdL1ZrJmecjmafVV3uoGx/Vlj/mwx0fP+z+D/ryZ1FMncLjt4FfEnRkM84j0EVM2ip4bno2+8YJJlizZbn15KtBTjnmUAPL7fRfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKZgAuz+c4gol4DDIQurnB+d+2yWSsnXas6hw9ost78=;
 b=Ce7lCmvPmBBuyykr3bmKSUMpjCltqWZGfC6vH4Yg9sOiekYycjv4vTMz4k5rx91mOZqT5XZo5P/sRQyy10JtE2lniGBem1Soy8/TazBadF7Oe29slA9mxurTGVCdA8hQZuZjj8hH9yjNYwvW17YlHb7M+N0Q6s/roVHNnXqH2KD+kbj4VL5+kDl9G6JWgTx80hJ4fK/q0DNX1uGwVEh8mZ9auF5g2V1YTgZIeqgRvU+sSJZjB8DmkDhbpTnF9nuf19sKb8zVoiADJsjreGNmyaxytNm4ZzOFuI6SXBCM/0fZZ0YbuPb+oouwqlhJRWJjxVRDCespNXQgduo9rSHRLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKZgAuz+c4gol4DDIQurnB+d+2yWSsnXas6hw9ost78=;
 b=PDbBoISm47/JU91h8BPR8V1mRtsBf3TwQMgYF0EKK/NmoUlNBrvbmGLB41Fpa5cClJVKgnqsqSS32c9GJ3mVx5KdasCgpgoq+FlZ7ML388jnQvqRtACHNNCZ8NqDCh3clJK9QyQ0TvMN7auL1XKTVZ5HCoo2CSrkWMPF7o84Apc=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MW2PR2101MB1001.namprd21.prod.outlook.com (2603:10b6:302:4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.1; Fri, 8 Oct
 2021 19:33:28 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::89fe:5bf:5eb2:4c55]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::89fe:5bf:5eb2:4c55%4]) with mapi id 15.20.4608.008; Fri, 8 Oct 2021
 19:33:28 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v2 2/2] PCI: hv: Support for Hyper-V vPCI
 for ARM64
Thread-Topic: [EXTERNAL] Re: [PATCH v2 2/2] PCI: hv: Support for Hyper-V vPCI
 for ARM64
Thread-Index: Ade8aA2v7N19jp6XTU2lQwhKOEXJNwAEdm2AAAA2P1A=
Date:   Fri, 8 Oct 2021 19:33:28 +0000
Message-ID: <MW4PR21MB2002960D6334B8E82670369EC0B29@MW4PR21MB2002.namprd21.prod.outlook.com>
References: <MW4PR21MB2002619B2F7EEB9B1C4F5712C0B29@MW4PR21MB2002.namprd21.prod.outlook.com>
 <20211008192259.GA1366435@bhelgaas>
In-Reply-To: <20211008192259.GA1366435@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fdae7d44-1f7d-4c14-ac37-3e79f2c2e202;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-10-08T19:29:03Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46be50cf-cc93-40ec-e0f5-08d98a928109
x-ms-traffictypediagnostic: MW2PR2101MB1001:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1001E1855A1F8D4CAD0AFFA8C0B29@MW2PR2101MB1001.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: avMcfry7a3A6yNd8L/AKGNRBTPnD9IIrN0qQaFffDYE0vDLp8NYydrntX5iy8KMn/DjlbVDj14Q4Tu0huhcHXgfOLUVNAOrJOUc7c84CLZofh3Tt/yX5J7AJ3saAmIbawQY++dJvH+ReblvD3jJC+L1vUCEnOo5cWGuvHvWn4KdOtn6EtKm2tSLW6eaKm6ouY9dLG7QyeL297krTCbNzTfS+DqG7lDyvM9PpLfv7QZPb1vlX2eSrkHRFMmC3GEwJexFnCi0+Ml0l7WJB1MXbvZS71it9++aWvZs3dGShI0Bly0iSY/a7IAf41QLlwRw/UIN6jjJYpb/3zQdS2qQa2x9PVYcp/MelyBDrZoyfdhQrn/awLweeaPDZN+EkFOqNn524bmZquH16XXOs681Qiq/L6G7/rCv/dh5Iz2h4W5j21gz0g9Ku2fo+pU1ggD7cvZPuCsC2uISlmy36Ej8fafmkDq3SDg23S5h8Zm8GkocH+zmSBwLLmpnzBWwT21C/QyJ7lwzj59yEWqeqRdQ/QYgRB8xLRQHQBkQff/zFY8CnlAG5fk/OuVt471RE323FKBhjwuhhbdIxK+2vZ2sRuoSx2l+h18xYGsZ9/Q6iwCJb/wzaA3+8OHX66gdzjc6jYRL81pxdLjv9f88W+S8JHu+BJws/3hneHZilbeM6mbQ81vSiPwo1+y82XcsJUSxS3Dl92o2H6+l4xdE0XvxBIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(9686003)(86362001)(6916009)(55016002)(38100700002)(122000001)(8676002)(4326008)(7696005)(71200400001)(54906003)(8990500004)(2906002)(7416002)(66446008)(316002)(66556008)(66476007)(66946007)(10290500003)(76116006)(64756008)(5660300002)(186003)(4744005)(52536014)(508600001)(82950400001)(33656002)(82960400001)(38070700005)(53546011)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?4TMfvOKoTtjYUtfeOrVa09yivD5D/Z1Ql3GXlxReXCTl9PJvRO8rqaVqXU?=
 =?iso-8859-2?Q?PkoGh5hnOn9RqYJgqdlhIRIhUzAoxYWM3caFciNcEwsCNRz2OkJ8Vbbxs2?=
 =?iso-8859-2?Q?Qg7mXp8QBqgPm611yYI53rC+E3imyeXpyT0hSfIzyxxMZDFPE+8JFAD31x?=
 =?iso-8859-2?Q?9U2ukpEZIO5E0pQP6dxiewEUj2D5bFSzvrjDEjBnst875L3o8SZqoPy8Wp?=
 =?iso-8859-2?Q?RDFiL3T1IamoP2E/tTjBOElN5Hg85A75ZU2fU2nQ8ZJeL8XI1WJLeuZSy+?=
 =?iso-8859-2?Q?sm53gAGIQlk/cC/86/SZW87RYnjHDBf6k7Kn3Uc+Aqi1Tt2xe4RdjA/Wyk?=
 =?iso-8859-2?Q?Nl7uC91fW3Gwcw1E2Q6ngBpov0rQ1y/Ugb6VtMQWdPUw4vxoidB8NNKrvo?=
 =?iso-8859-2?Q?HWO0aZv5AW1mIu+bZBfUhvNLJFcp3dqNbvwmE2DQ1rEK8Dx0VeONSFABcm?=
 =?iso-8859-2?Q?W60Sj6jd7Qlod+/DVFi5phBYTVw4XoLgtum6VvOKGgrG6uwturanpSNMFJ?=
 =?iso-8859-2?Q?gOQc7CgbGwds6NmxUzqyHXSULlmQ4yFv1Zg1Okq9NAV4jjpSDxRRebA5UV?=
 =?iso-8859-2?Q?y5bH0HBs6XUBUf37mpwmmtBQ7du/688Wr3clxt+hPW5C9uJ0gA+o5bGF4J?=
 =?iso-8859-2?Q?ssAoDOgnvYGY6XovkFzbfxrIJ9va2MPsfxYbl3IMt8xlmjmqJBLV93NlsN?=
 =?iso-8859-2?Q?Fw5WbYdsm+YQ68p1CDOVIan+fBXdXupNxikzjVIRnMXQ/jtYhI3wDE9twv?=
 =?iso-8859-2?Q?74+dcADAzYifI4nDAQOA2Ttn6NWftWk593GmTgfMYZt8oMees4yE0EF3CX?=
 =?iso-8859-2?Q?09XsvbY7oKLGtK6D1pfp85kVO5Ocm2FAvDxN0QjcQqyxeY4IAqgt5rjPmN?=
 =?iso-8859-2?Q?e90FwZP8v9SJA9XQdgHBdIqWqLPSyIRlQ3Oxsc+TTyg37RGqi8tHK198ey?=
 =?iso-8859-2?Q?9N92kghR/r4o892/UpZjdOEHgvFi5Pfed2EVnNEQsevgeCoiSvGXXKeKYO?=
 =?iso-8859-2?Q?8PhjFLmv11vew8kLpJuOxBJmmdDHtAAbfcRJeWNvLEObe+SD3c8/3TzH6f?=
 =?iso-8859-2?Q?TOtMFQfnlbOtcLAzSZfgsxOkko49ffeRn5aP1KbW14b9Mw7kZTxqsNMAVv?=
 =?iso-8859-2?Q?4v/zJYIfUTm5lcECzXwF8EsUhSF7DZPCyo1SEy3lVAcPLRbBZZqooB4nzw?=
 =?iso-8859-2?Q?KubBvik44WgsoS1+t+FPDjMj84vnjldzEMhpJ1WtTAHsJi0sRaiQaMaMq4?=
 =?iso-8859-2?Q?1qp/udMmIu/KrxOhu1LL98KbJH8hR58DqD2HIOdIV9jTHng5KVf1jC/mqY?=
 =?iso-8859-2?Q?KhV9jrAx6civvZgMSsXeB4Xniu36oPKuFajzznoHdMvq3wAaHpW5zEy+sc?=
 =?iso-8859-2?Q?zB+5RfXhBvQTC/W1qz56EEobQubQszmT51oZ46y/tB+ScHDacYQ2V9Ujyi?=
 =?iso-8859-2?Q?V4v+uX2fofmQ4zcV?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46be50cf-cc93-40ec-e0f5-08d98a928109
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2021 19:33:28.3795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3wr6zJQE/X9FfNDQ9sXwzAiC2rzf7Qh03ygU3jWg6NJSlWjoB6k5zM5REThLx47QZZ6gAYFF5A4SEcBzF8BWUZGd6Ggu3q0qApRH3Gr6TS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1001
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Friday, October 8, 2021 12:23 PM
Bjorn Helgaas <helgaas@kernel.org> wrote:

> Subject line should start with a verb telling us what this does.
>=20
> On Fri, Oct 08, 2021 at 05:21:29PM +0000, Sunil Muthuswamy wrote:
> > This patch adds support for Hyper-V vPCI by adding a PCI MSI
> > IRQ domain specific to Hyper-V that is based on SPIs. The IRQ
> > domain parents itself to the arch GIC IRQ domain for basic
> > vector management.
>=20
> Same "This patch adds ..." comment as for patch 1/2.  You could say
> something like "Add support ...".  It would also be good to include
> "ARM64" since I think that's the point here.
>=20
Point noted, thanks.

> > +	/* Delivery mode: Fixed */
> > +	*delivery_mode =3D 0;
>=20
> Why not APIC_DELIVERY_MODE_FIXED as you used for x86?
>=20
That is because 'APIC_DELIVERY_MODE_FIXED' is defined under
'arch/x86' and I didn't see an equivalent definition for ARM64.

- Sunil
