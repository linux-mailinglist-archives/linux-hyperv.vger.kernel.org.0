Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639B1427137
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Oct 2021 21:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240320AbhJHTNb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Oct 2021 15:13:31 -0400
Received: from mail-oln040093003008.outbound.protection.outlook.com ([40.93.3.8]:25078
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231342AbhJHTN1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Oct 2021 15:13:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZxxr0Zg6HcWdIe+TDO2lWza9wis6JR+zznmBUwNKiPB2ALxKB8HipMQ0bOyj9SveNoNywJXDmIZNRMqov8sRIXlRfvqfSBw0k1ln9DgCuhX5vazRbg7QwoXSmVDgESZFbtPkFn8694wnmjwQuZrN+vPgAbs3KInSwLpOTV/cQjVvymqAHbrF5skxefyilMftQg/oqftUsfHKaUjHQxa4Ui8gN4WS1ovBBm0EYkbn8JZXZGlkfUilMMhR+t/EQ42qsquLIbRPYUnYr2gR9Uze7PT92QKtDs7XKbk7v9UrDRTEfYfcuDWC4qxPTWKBL7/5DnH9mcVk7wzlo8ZZFKp7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7b7Hy9qv7vhx9YqwWZuAq9LhRU9L1emvVhB7t5yuqU=;
 b=JsTtoD9rG/6WNvJf0ZfYiaACtNBnY+xfH8cLXamv4BM4KqiEPguHNoatX0EwyDm8stbafp4UT7PSGQWIARjTy8FcEvDzZVIxR56Q+NDdkZTJfIq1sHXsFREZ0UTWzs9YE+vCjot1ndwTYxJm4n8JmFCsC9NevSjCe0+u3+AUULHy1X0FKDHlTdgQbhfWRCT7BD79okAPva6cNt8M3ufN0CtFSO5jdPfmKmYubezHjGfLIbUYG4r7kizJLqKyWv27FOo8J/3GR/UVOphytllVSbmJIw1KuS+FKXuuEkqIRgmBLePOwro0G8tU5mxLcUneGx+PGKXIYxX7INnKVuUIhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7b7Hy9qv7vhx9YqwWZuAq9LhRU9L1emvVhB7t5yuqU=;
 b=A5Myc+DvBQfgTB1EesQC3HzeIKFe8biuG+aKZdnN/QtqJ0nxinBlXZZNcTv23vD6AZcEL+KppZZzidT/jvFuxvLAWOpAfjddy7G5rrccsw9rS57fMZyMpCUWXmZYaYw7cTyLrGlRPGeVywf6tEiDya7O/hWHC2YXwGZnkSVJ9rQ=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MW2PR2101MB1851.namprd21.prod.outlook.com (2603:10b6:302:c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.1; Fri, 8 Oct
 2021 19:11:27 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::89fe:5bf:5eb2:4c55]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::89fe:5bf:5eb2:4c55%4]) with mapi id 15.20.4608.008; Fri, 8 Oct 2021
 19:11:27 +0000
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
Subject: RE: [EXTERNAL] Re: [PATCH v2 0/2] PCI: hv: Hyper-V vPCI for ARM64
Thread-Topic: [EXTERNAL] Re: [PATCH v2 0/2] PCI: hv: Hyper-V vPCI for ARM64
Thread-Index: Ade8Z9t+jRUuLsS9S2C/sb8+Gj5obwADb06AAACWIGA=
Date:   Fri, 8 Oct 2021 19:11:24 +0000
Message-ID: <MW4PR21MB20029E72816E8559053B0E4BC0B29@MW4PR21MB2002.namprd21.prod.outlook.com>
References: <MW4PR21MB200217CCFBC351FD12D68DF0C0B29@MW4PR21MB2002.namprd21.prod.outlook.com>
 <20211008185209.GA1362885@bhelgaas>
In-Reply-To: <20211008185209.GA1362885@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5d997d76-5a0c-40f0-b68d-e5aba94ba3d8;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-10-08T19:08:56Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dad0b2f5-d38b-4113-ed97-08d98a8f6df2
x-ms-traffictypediagnostic: MW2PR2101MB1851:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1851F7EA2FD0D0A9415C8C56C0B29@MW2PR2101MB1851.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +L1wIwn5W8tCTbI3c05fCXpMDYWxJBgm2KTarOVFJR7Yo1sTnadStFaNTEG6n7micKyy6kl14nW73eZkZzt4UX6HUeiEvXmg1VyQhZyhyBpQcAqvBUKyoPIJfyYZvEqoC/+ujacRj0clAQWOOBDK3iNnmGRrD5e3BHTGrpirzBdV1rdG/rINFQquFcow2TV9r2w1gQ/M3RQO9J8P4ePGFAhPBoUrS1kH3sd7VRIelqi5QoCsA1vBHqsXD2yarzESkgSpL3eVlZrCo4He2ABQQki5cofhK1EaozfEp2zpRzYZOeFKc1cHYPN5DE2iznjBJaPnB3EGFgUaOLih8xmJjZlV7bjWLKEWbDcyJWTecSV4ScX4aR1mIpMXtfgb/NwHCVu5V5P3jB0W2bwLs5hEHhucNG+5FILYme45ER4Lw/uEWQJ6mCofZJTA67vos7AZ2P3GUz5ipNqRpo4wTG2vlxRw3sH9bh6+q5lo+e8ImjWcDuzEnceMRL1ArHz0fYboTNbDjClnSfiDIGxPdgJLSSCgnHD8XFOAJwPm4gdZ8EOay4X5gTPjB87cCF4orqIlLQIpYezy8fAYVfSKjoAVlBvM3PoG3jkum+3qkh6KONa0X2XQvwCjtIgF1qMHMOqlOXYDgTS1Q56hWbyHhThw0fF4dXK/MUB7NlyeEa9IGMWtMqClzGEYN/f8WFLLXGDCYxqEyQILClg9BPMX2lCkpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(64756008)(66446008)(2906002)(8676002)(66556008)(66946007)(82960400001)(4744005)(71200400001)(33656002)(52536014)(55016002)(122000001)(38100700002)(6916009)(86362001)(6666004)(186003)(9686003)(82950400001)(76116006)(5660300002)(4326008)(8990500004)(38070700005)(316002)(83380400001)(8936002)(53546011)(54906003)(10290500003)(508600001)(7696005)(6506007)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?YOd5nTAXTivPQopJkYfHNZGuUIc/uTXWYMXFWTmUEBtPC93Idyp/TncVu/?=
 =?iso-8859-2?Q?zY5Yz7/j7MVlCIRnbt1r9UElSwdXd7eAMLV1Owr4aqi95UuZkkca4HSenE?=
 =?iso-8859-2?Q?MiL4E8egf7vYX0RicMEqYfwZK7r/SnzmwDkkbpiac5MjuI8AtH/8TL/JOO?=
 =?iso-8859-2?Q?rRaxRH5Ex0Pz0qT0slgQ7MA7J+srWQw4volbMd5qhqx8tB9J8GNnT5wQqq?=
 =?iso-8859-2?Q?g58GbmRxWiArBiTwBLJd6h5SIXErZctdgP9vLQUVlYUCYaBeEBIe9HOdI2?=
 =?iso-8859-2?Q?+ajOLlbF/MIBa8G0/ekEOd23q62Ct2SBjcBQ84RvbbMSsOoVqF3mmkhKX/?=
 =?iso-8859-2?Q?EMSGYtZ6KKUjQFLdxwPRz0C23wrrlNWtd/lkE20iedqQMpqq8O/AyDh9GO?=
 =?iso-8859-2?Q?4jvAtwodMNJ1+OUd9t0RYAvS2Zkthsk3cDLiF9rhDKAlhAE74rzZxXGO1j?=
 =?iso-8859-2?Q?fEodr49h0bWici/YY/0qkaRGMQFZCl37btHkVGkPcqrhogc/Um513FIm+B?=
 =?iso-8859-2?Q?GdDbLinQodgvMmiTusuxRgR8xxpmm1S8wfyhmIw2GySnQFIgttsBwUCgWj?=
 =?iso-8859-2?Q?8ehJwle9CaEfp1iA3VUNbIjjGW+QFmFH9VJmc42WAuPo0+qvngVhj1Wmbr?=
 =?iso-8859-2?Q?fK8w9Vwwva20gXKLjIZe681gDT1UD816beTriL0Jbz/MbKsEYk7K1JhY7u?=
 =?iso-8859-2?Q?WkaAu3A7yS268wuqJT2xqMXYcCBGz0wL/7QHNnlNveQQVyUenO1SLyu0li?=
 =?iso-8859-2?Q?uTTWJiUsy2ocoZ8zqr09nLztzKRjksv4ldNF+XDQJPi5/D1UHryw3zmIOD?=
 =?iso-8859-2?Q?WB7Dvpzh6NhR2eDN8zfwT29nyFtpAqUS8bOMUGL0fyJkCkquWaaRKEyJyZ?=
 =?iso-8859-2?Q?jzHmDz0XnguEyVdETGGoAiY2wyvO1GisY7ur0kmamQpC8ovYhhRrdg9Bpo?=
 =?iso-8859-2?Q?mh6ryb7745xVPLSj18zp13wzAf6CjhfEvNjpZvmPsPc1dIu2IEE3eDe+Er?=
 =?iso-8859-2?Q?R5U3FlSTfwCTi6tTQpESc6aJQhYGJpspyUBlCwEn5ldVb0nzFTVgeKLLuS?=
 =?iso-8859-2?Q?/xX+jw781iirpseDqGaXCX7Y44wYvW7OVCFda12mkoRG3W377TEFNeACjG?=
 =?iso-8859-2?Q?Bo9IVaq6Wykbr4YNxSQDm0I1cl6uM7rF6bXerfSgg5MNMSBeMQt3NJ0bia?=
 =?iso-8859-2?Q?w1npJRBfmJ7C+LvmYXgSW2TWn/ckHeBaZqVZbUQr5OIixHa9US5fVUEcJG?=
 =?iso-8859-2?Q?ItAo3Q8HYAr5REa6V2Zcbt6xjQEiURbQPRJU3sisN6sgxmzgYlTGGp5WEC?=
 =?iso-8859-2?Q?XgVgfmF1+8gCtucq8657BFtWFofkFGSkSIjJ/yZIiy6xODXvUnaZuOPVf9?=
 =?iso-8859-2?Q?bB1fLSW1KmTUbDM3nS0oRe/ev7rdfMLAcwDDTaMgOKU2AUwr7zFH+wMK8W?=
 =?iso-8859-2?Q?HZNBNN+YuMsOVALZ?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad0b2f5-d38b-4113-ed97-08d98a8f6df2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2021 19:11:27.8203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A3VhaYwk2xWSym5++RCQup6tCqDEozZk7iIuPTi7Vt9SJDQQIvejYPAb5TFCtApC6HDp09Z+mSrz0uKFFVRsQQeXox4yHB+tyfhNO4ZtNuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1851
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Friday, October 8, 2021 11:52 AM
Bjorn Helgaas <helgaas@kernel.org> wrote:

> If you have occasion to post a v3, note that this is not correctly
> threaded with patches as responses to the cover letter.  Thereore,
> "b4 am
> MW4PR21MB200217CCFBC351FD12D68DF0C0B29@MW4PR21MB2002.nampr
> d21.prod.outlook.com"
> does not work to download this series.  See
>=20
Yes, thanks for the heads up. Appears to me that Outlook doesn't work well =
with
patch series. I will setup the 'git send-email' and make sure that v3 is th=
readed
properly.
