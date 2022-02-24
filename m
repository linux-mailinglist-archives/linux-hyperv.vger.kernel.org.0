Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D0C4C231D
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Feb 2022 05:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiBXEpL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Feb 2022 23:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiBXEpK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Feb 2022 23:45:10 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11020019.outbound.protection.outlook.com [52.101.56.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28E4264985;
        Wed, 23 Feb 2022 20:44:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGB2m2Ado8jlzpQ9IR8b7Bf5LQwE0abiw9H+tmDAKgh2UAsCrt9nmN7SG6beNJ9s9HHqiumkEuqs1dkZoFl0AhaaTXEv2ud864L8tbf/XFsScoIOexofteOOJtCpWklHtDOPi0TQc2tUOa7PwKfKj/Tk59yEjHWpvVDw4PJlwjKgJBBNiJJ+PAryGPEiCaGLxoP2TZzpe31cCH5CRwYaHU7/yuc9ossnVMBKZf+MhOaIREieU7inoaheT6L5z3MvCKjbw0CtBO792la0QrMaDllUp4HNtcf/KUt8zxxPjPKm4yqs3ASkpClYcdCTW+aALcaoEoSOMlAdVdrhBjvAAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiNfQ0I2MRuP8l8DE6RVbg9lITOWR4a6EbFbVnIOPG8=;
 b=Av0Beh0sF2WNXSQRicoBsUFwDzcOCOYHGZX11RY7H+gndZdQz4ajT1C3Tg5ZRUUGeSCEiS5rZich1v2wUyS/sAFK1QO8wAcDVW1kT+D3hB707hgURKmA/I4NZtEAFzkFezJ+u96UvGzsdeiX5jP6gIhKvU3DduRtJUmEDfgM/BXdsud/g7X1DMcH/4LmKHJcQXMADgRwE0SHKHZO1Sd2Jz6HsdXD1EbfFidsU11zGD6MO7PNi0XzIVBKYg8vguGYtFoHLK2N5mcRauzQ2v4knA7+bqm8QPg4Z+aIxQbXL741sBhLnv7mN8naBC4QRf9N/Ci7C99x+2TLMYJB31N9Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiNfQ0I2MRuP8l8DE6RVbg9lITOWR4a6EbFbVnIOPG8=;
 b=U2muNFOKFiyhN9RxfHBp7wrTlG7KqVg4kgBVaqkzWOCZRKq28pn8lvFMH8OXAnabH9nGFZNfDGPh8Tb+RkhesS5LrpNhfoHGykSQFl23lckSqwAr5f4yJaX/LvQ2A9gBN0N27V+Ji24jnnSnTqGVN1V3/Tvh+mhFyqG7bG+9inM=
Received: from MN0PR21MB3098.namprd21.prod.outlook.com (2603:10b6:208:376::14)
 by BYAPR21MB1272.namprd21.prod.outlook.com (2603:10b6:a03:109::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9; Thu, 24 Feb
 2022 04:44:34 +0000
Received: from MN0PR21MB3098.namprd21.prod.outlook.com
 ([fe80::69f8:51be:b573:e70c]) by MN0PR21MB3098.namprd21.prod.outlook.com
 ([fe80::69f8:51be:b573:e70c%5]) with mapi id 15.20.5038.006; Thu, 24 Feb 2022
 04:44:33 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Boqun Feng <boqun.feng@gmail.com>
CC:     Wei Liu <wei.liu@kernel.org>, vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        David Hildenbrand <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 2/2] Drivers: hv: balloon: Disable balloon and hot-add
 accordingly
Thread-Topic: [RFC 2/2] Drivers: hv: balloon: Disable balloon and hot-add
 accordingly
Thread-Index: AQHYKLeM3sCLI+VUq0Sl7YfuaLrf0ayhWD6AgACnIICAACEo8A==
Date:   Thu, 24 Feb 2022 04:44:33 +0000
Message-ID: <MN0PR21MB30982F7739248018F5AA4A96D73D9@MN0PR21MB3098.namprd21.prod.outlook.com>
References: <20220223131548.2234326-1-boqun.feng@gmail.com>
 <20220223131548.2234326-3-boqun.feng@gmail.com>
 <MN0PR21MB30985DC877AB58DD1A849900D73C9@MN0PR21MB3098.namprd21.prod.outlook.com>
 <Yhbw+9rEmlBP3hNd@boqun-archlinux>
In-Reply-To: <Yhbw+9rEmlBP3hNd@boqun-archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ce8e5549-3c36-425b-b04d-27a90cf30811;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-02-24T04:42:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7aeb782-8ef4-48e3-130f-08d9f7505a57
x-ms-traffictypediagnostic: BYAPR21MB1272:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BYAPR21MB12723D02866EA43E3DB7978AD73D9@BYAPR21MB1272.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rqG6SzTM2rK0AzUri6nmqhVAY7x5HvxdqS9mm5PIz8WaiczC12iG6ZfPAVLZ0eVhguSQpdEjfad7ntjYn9nrOo7jGS2gq9cfpNeVmC4U9nwJgH2FLmdj+DMxRItU13F1gREkMltGpDBDKeR4rzsE4FHo3eVyL88ceLg3/mmeno6ea8JR/f/Wu0zttm78JHOi1y7iYi8RB6XUDWVIyYjjsluM6Vek5G2vjR8VxGp7Cp91lWFOha/bYUNwJaKUrWq4RVfBcCjMmxES4DoLFoS3K20Z0AHscO9CjXvcs7WTiQBehvUqkxaAPF+kzaziNTWjnA1rbmPaoU04eOXsXB0upXlBHTHMbOczOCfolgUX4dnTE1uFeYqDhQqxPwQNw1/VJ+/PmSs7UgS1c0I6F+Ol7nZoDUOyMDJBMNfhsWMUyyevYEJ6VhfslUF3XEB49UKu3tM5ZL4wpeqTwi1qoVTWJEx92wN7ECksOEjQFTAsF4ePopcQ1nQALxeEf35/5Oky4SEKLPf3lAnCTRr+XYvlfihHG1+TXnXxt82qqCP5VNR2WaJh2zqX9gu+GJvP4bGbADlruqBR1Bzq24ymIBN7VfAG7OkTgAIt4KnpkcMv6K5XDuWLvSzn7+8HTxuxHZ8zhANnkittvghog4vtohlOC/3IhsuyO3VM7xYykKCOLdw/JwRKDU+kmffXSOifj4tQl2cPyGZ0jLeWpxC8lkSz9b2skQ9ja6LqH2/EGC+uWQHkUS4sXkqz58Iin6iV3lWy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3098.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(71200400001)(8936002)(64756008)(8990500004)(52536014)(186003)(33656002)(508600001)(9686003)(2906002)(5660300002)(122000001)(82950400001)(7696005)(38100700002)(82960400001)(86362001)(83380400001)(55016003)(54906003)(6506007)(26005)(6916009)(316002)(66556008)(8676002)(76116006)(66476007)(66446008)(4326008)(66946007)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FCzXxe9+1XRGMhWOztFAqs91TCJ1VRvBjqn9kkScJIRjuxoaNidZarjCASPT?=
 =?us-ascii?Q?4qLLWIDibhsf41uQQJiGfa7NKZRqBBRF6kkzYcfL04/DuGdzCvbS6OkvYfXr?=
 =?us-ascii?Q?4g7tOa038B1Is5FvPq8fe1nqttdtlPqdazHfYdcrvx5wPfXax4j0/w6/K5KS?=
 =?us-ascii?Q?0XddQ1uUUFDu8oje5uwUnFB+W2JRhMRpgfvcWc/G13/t2DXpNcqcpZVAKpcn?=
 =?us-ascii?Q?8499CBRKUUeZ1ix9/GXw4C+IuB7KQKjlAyX0Dzd437GKh1Hh7+69Xd2kexDs?=
 =?us-ascii?Q?O4cgw9EJMHeFFhfFax0y/3M8ZmS4e2SCebwQhADzcpoaAMO9x8J2oOu/HX9t?=
 =?us-ascii?Q?C9g5lu9zS392TBYIcdkjnaI4j1V51lSVREVXV/ufh1yq8Z8Xw6QWf7dZk1AY?=
 =?us-ascii?Q?lytBwW109llkO3qytJBfC3b18LBFDJnefEY+NIf8PUHv4ml7Ul8tt3LvDh61?=
 =?us-ascii?Q?AVre69Zj6IFnD9/8Np++iyXXqv5GdUuUoszmt1eYOlvGJgXsNXAF2/jTD4Ws?=
 =?us-ascii?Q?wOE2INifev5nEtpC6nrDgTGSKyKx9hi5R/XiB6KpiyO9Di0J7r95apq1YUOm?=
 =?us-ascii?Q?q2QWjywiFPg8g7bzj9xRTEDfKZAOtoE+uRD4zof36HrrxY8GHuACMU7RwRfV?=
 =?us-ascii?Q?JLz/6fTRT1ssv4P3XbCBEH5dZWmo1QbtU/qsFlAZKfNKnSD7yj8tW2TcmAte?=
 =?us-ascii?Q?rjbJwyw1kEJCJx4W5Z2oRxoxO9+D5J7e8S4PUwoGAv3Gg74SsWbYAi8p584A?=
 =?us-ascii?Q?rDd8BgBRqt/gB6pu1WzmBjbMIlXT5/PVfpYTetTVE5kSrQ+Q9NJzUaszZStu?=
 =?us-ascii?Q?Y1Jcg/PVqtu9wWmmoruGWaJavpGTWLQ3T4dj0ViS2+1J8XLVijG3X7qnzXcp?=
 =?us-ascii?Q?HabXHM+uoP/WMjKdOXLJgPruz7xOTfmjSPUC+s12tmeMbcSPE7pRAlgx7KL6?=
 =?us-ascii?Q?7y3ZUc5ORzFQuvy03PXZX7WyjvIYp/szKic1oL5jD8V6bAgwIAVLhk8edhSc?=
 =?us-ascii?Q?36d1t1v/PytOTNiK8PSJI+CDOcCCCcCzy+gDrogDt+lO+ZE6MZ2sgFGhh4bp?=
 =?us-ascii?Q?RTu7XXU4JsAIIfnsjz90vgQEO9JOKbP/fbb1W8ns/VH/oIKGWBS41376bRj8?=
 =?us-ascii?Q?dACTzKhlmLak3Acq+ZQ0yxwx6TXeMf/FXXUOBRj09KgGaI28n5kNYKfUQcGU?=
 =?us-ascii?Q?4rIPld1bcH1WsxMy4RldwN3YYjIIoynaJdw2XCDaPsJi5ykVTGH+yftUJ0+n?=
 =?us-ascii?Q?NXx88R3uYqH3sW/d5kGH7wZHKnF25pvhzgSLwuT+kygAGfA6d/9zZtDptHMR?=
 =?us-ascii?Q?Fq/YL1ArjsUjPlR5v4ZKCXbB8YNIqq/VOqedjvSDGzpHbq9ywl7e+k6hcddu?=
 =?us-ascii?Q?FiDZoYN1JpaAY+aIPAiTxFBgKAPcs+hzdGYBwTWHB3WDQ0i+RSGb/e7QAoSN?=
 =?us-ascii?Q?wPcLq+baIgmxMago6y6kOCPrs684lgs5JV03sQMrDlLJ8TAdsTxgOptWDgvb?=
 =?us-ascii?Q?XNJXy1DlLGqoQC7t7nS/KpO7B/HBV73n8J+EQK6bXhHb1QO2HNbl5oMUnKQv?=
 =?us-ascii?Q?Syyw1CeajQ6SX4yz0N0N4JBhW2xpfDc3+YlDShsqhIhSUWnwYppDvwlq8W08?=
 =?us-ascii?Q?r4qEcerYpyu9hL4BTf1+ze/MfEYf5WXLE0XA5hln+6erDXmGWbQHjxxasoM+?=
 =?us-ascii?Q?4yUl9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3098.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7aeb782-8ef4-48e3-130f-08d9f7505a57
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 04:44:33.3836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ACtTX+/nYAdqZ77aQCb2SS0x3P4pQuVPL3N1R/ZsR606ztbPLB2TvG1nxVvowAoueG5b7jcCcaWD4YTXCNErHV5AiPvtu9wnVBaNk1RjIFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1272
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com> Sent: Wednesday, February 23, 2022 =
6:44 PM
>=20
> On Wed, Feb 23, 2022 at 04:55:25PM +0000, Michael Kelley (LINUX) wrote:
> > From: Boqun Feng <boqun.feng@gmail.com> Sent: Wednesday, February 23, 2=
022
> 5:16 AM
> > >
> > > Currently there are known potential issues for balloon and hot-add on
> > > ARM64:
> > >
> > > *	Unballoon requests from Hyper-V should only unballoon ranges
> > > 	that are guest page size aligned, otherwise guests cannot handle
> > > 	because it's impossible to partially free a page.
> > >
> > > *	Memory hot-add requests from Hyper-V should provide the NUMA
> > > 	node id of the added ranges or ARM64 should have a functional
> > > 	memory_add_physaddr_to_nid(), otherwise the node id is missing
> > > 	for add_memory().
> > >
> > > These issues require discussions on design and implementation. In the
> > > meanwhile, post_status() is working and essiential to guest monitorin=
g.
> > > Therefore instead of the entire hv_balloon driver, the balloon and
> > > hot-add are disabled accordingly for now. Once the issues are fixed,
> > > they can be re-enable in these cases.
> > >
> > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > ---
> > >  drivers/hv/hv_balloon.c | 14 ++++++++++++--
> > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> > > index 062156b88a87..35dcda20be85 100644
> > > --- a/drivers/hv/hv_balloon.c
> > > +++ b/drivers/hv/hv_balloon.c
> > > @@ -1730,9 +1730,19 @@ static int balloon_connect_vsp(struct hv_devic=
e *dev)
> > >  	 * When hibernation (i.e. virtual ACPI S4 state) is enabled, the ho=
st
> > >  	 * currently still requires the bits to be set, so we have to add c=
ode
> > >  	 * to fail the host's hot-add and balloon up/down requests, if any.
> > > +	 *
> > > +	 * We disable balloon if the page size is larger than 4k, since
> > > +	 * currently it's unclear to us whether an unballoon request can ma=
ke
> > > +	 * sure all page ranges are guest page size aligned.
> > > +	 *
> > > +	 * We also disable hot add on ARM64, because we currently rely on
> > > +	 * memory_add_physaddr_to_nid() to get a node id of a hot add range=
,
> > > +	 * however ARM64's memory_add_physaddr_to_nid() always return 0 and
> > > +	 * DM_MEM_HOT_ADD_REQUEST doesn't have the NUMA node information
> for
> > > +	 * add_memory().
> > >  	 */
> > > -	cap_msg.caps.cap_bits.balloon =3D 1;
> > > -	cap_msg.caps.cap_bits.hot_add =3D 1;
> > > +	cap_msg.caps.cap_bits.balloon =3D !(PAGE_SIZE > 4096UL);
> >
> > Any reasons not to use HV_HYP_PAGE_SIZE vs. open coding "4096"?  So
> >
> > 	cap_msg.caps.cap_bits.balloon =3D (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE);
> >
>=20
> You're right. I will change that to it in the next version.
>=20
> > > +	cap_msg.caps.cap_bits.hot_add =3D !IS_ENABLED(CONFIG_ARM64);
> >
> > I think we should output a message so that there's no mystery as to
> > whether ballooning and/or hot_add are disabled, and why.  Each setting
> > should have its own message.   Maybe something like:
> >
> > 	if (!cap_msg.caps.cap_bits.balloon)
> > 		pr_info("Ballooning disabled because page size is not 4096 bytes\n");
> >
> > 	if (!cap_msg.cap_bits.hot_add)
> > 		pr_info("Memory hot add disabled on ARM64\n");
> >
>=20
> I agree with your suggestion, however, while I'm at it, I think it's
> better that we have functions that check and print, and .balloon and
> .hot_add can rely on the return value, for example:
>=20
> static int balloon_enabled(void)
> {
> 	if (PAGE_SIZE !=3D HV_HYP_PAGE_SIZE) {
> 		pr_info("Ballooning disabled because page size is not 4096 bytes\n");
> 		return 0;
> 	}
>=20
> 	return 1;
> }
>=20
> // in balloon_vsp_connect()
>=20
> 	cap_msg.caps.cap_bits.balloon =3D balloon_enabled();
>=20
> In this way, we keep the checking and reason printing in the same
> function and it's easier to maintain the consistency.
>=20
> Thoughts?

Yes, that approach looks good to me.

Michael
