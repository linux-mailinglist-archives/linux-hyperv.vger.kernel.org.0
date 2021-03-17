Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB4633F9F6
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Mar 2021 21:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbhCQUbC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 17 Mar 2021 16:31:02 -0400
Received: from mail-bn7nam10on2119.outbound.protection.outlook.com ([40.107.92.119]:12094
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233406AbhCQUae (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 17 Mar 2021 16:30:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFCp5mjiSz1YVlvn1r8Gh73KONOOiXJ7pmeKdtxmRHual8++ERUuHNvmYJ13AzVXhDkwIuN3XOXn9IsijipqaVUaMuLQlosSlE2iL9ez7915PJymyd0S1rric1qPUFK4kx6KF1NgjcKtV9lZDaEeDbW1wIHqwWcnREdB3fQKYGN84uydknPQhgh5hbrSY2sv0v7u+3XpiJvYN70QQfEOq6SekaAL5wUMWPOi9fqXjVRGBWYAHzgRm8AUVjQ0XkKSkFtg4ZTgWOB2l7/N7BFxaAebcKyhoTwAC11neABWPXNx539MOzkSwXZMHkNFwnNOCr9uMZQgkyToDcyNZjYJLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xi9xMQCKTQ4/5z4GC1GdKqsc9RXAuIc1XvB6DhxT82A=;
 b=XJTkzcAlV3N+E3B3IughUHzGd3n6YxCHRe2FHrpLEy9PyRY+va4zbFH9btzPXHKXIy8yOQvL/EBIUXgtWEj+sgo+/dwMS87KyJQhCk7tkHXYKa+TtBs+7fkn8PcXAdqz2DZvLk/QvMwHPRp1bdWUK3gMr3fP0lwUjKadKYLpg3e+eIqogqy62G48WZb502ExwzrMqCW8LuwRHuYW9L4kb5LJQiE5lgnUyjy/huwdZUsa2vgo6WBZudYbtuCj+85xeTLDckWQKkOXpwIKd3FmbeVibe1IE7R+HnZYMA84HS7rgBwCco25mnslfyPRGnrrInZHVa141gswqWSam/F70Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xi9xMQCKTQ4/5z4GC1GdKqsc9RXAuIc1XvB6DhxT82A=;
 b=JeWMqXRc9o2JJ2RB25fSmVWaw0VS5q0ObYIeX6wb58PR8leZ0oKNRzddbMWfYLAhhR4o+/9+uVEOxUFiyfr64Ge0eVbkwA2ey+xL87+33R/fqLSw5Ja1B0kwmXtpCtsaQsSc7CwseJOvtcrRX1Qdvmt+3hau6ylI9aE7o3azwpg=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN6PR2101MB1631.namprd21.prod.outlook.com
 (2603:10b6:805:59::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.5; Wed, 17 Mar
 2021 20:30:30 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::9c4:80e2:3dca:bbeb]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::9c4:80e2:3dca:bbeb%3]) with mapi id 15.20.3977.005; Wed, 17 Mar 2021
 20:30:30 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Matheus Castello <matheus@castello.eng.br>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, vkuznets <vkuznets@redhat.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] x86/Hyper-V: Support for free page reporting
Thread-Topic: [PATCH v3] x86/Hyper-V: Support for free page reporting
Thread-Index: Adbkgi7u1VztxegUSBO0uPzYUvP03gWw0bwwB9jaLvA=
Date:   Wed, 17 Mar 2021 20:30:30 +0000
Message-ID: <SN4PR2101MB0880DB0606A5A0B72AD244B4C06A9@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <SN4PR2101MB0880CA1C933184498DF1F595C0D09@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <MWHPR21MB159313CE5C5ACEC4F94D8090D7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB159313CE5C5ACEC4F94D8090D7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-04T23:35:51Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=03e0cf99-fbde-437d-a81b-3887d9699748;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:56a:1a79:6db9:f175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 727c2e80-8d5a-415a-91ce-08d8e9838216
x-ms-traffictypediagnostic: SN6PR2101MB1631:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SN6PR2101MB1631EA7E0C83B907C0A2F25EC06A9@SN6PR2101MB1631.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kI4dL9ruB3BshGWih7ptRV1VWV6rAo+t846zgJjXQlQqEHORYcyfOwnVn3htveLD8mx1JWbU5Q8/u8idrNCwxKt0NW7c3FyKcOpGJqknniyaCGASslk2De7ErNl/Iu8SZqVwnr4mL7xB76sfeRdr02m9ujTZqa+TrjJ48rchbazXNEKgoxm6aL2hNjg+PYTPFoZlmDrCMonc5dgcOvIPX5pkGmgOzdPcJpy1zB3tYrOp9+hBtaJMao9lv7vfpZQwLlw0u6fckRAiVyxWFk3gRpoP8VTYHfGpsZM6vsPu6kbz5ha2jDx17I6yzjQxp/slKrDqjNFwkzHZ/vZ3yNiSGx1Jd8HJoMGaAGrASE8a6YaYv54Bh0c9PFCjJzo5lBhaYufUfkF1jAbTn2OgBw5cbL9KHU7uSZ+CQrTAG54l+kTvujAzreQdt8dC0jPRjwCzSNc7u1eokjD58ug/NEhwqgf8K7uTGTDkG4TY7w9KZqpLTXohcl3ZQakEa4mw89y1hOSYPy3UJ6d6KvtCt6VtJ+9Nj/Ae1jxAde+IWxBzFMFgwZHgMovcBX2YtD9MtgsNdnhDUKCWXc4ohFZT45atqHS1fxkOAly34ONkf8yIGKw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR2101MB0880.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(52536014)(64756008)(66446008)(4326008)(478600001)(54906003)(316002)(33656002)(76116006)(66946007)(66556008)(66476007)(110136005)(5660300002)(8990500004)(83380400001)(8676002)(8936002)(7696005)(71200400001)(186003)(2906002)(86362001)(6506007)(9686003)(10290500003)(55016002)(82960400001)(82950400001)(4533004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ZrCRMIWNEgy04JOfQpC5FWZ8B98XraX86NtGdyOc6VaOe051gr1duAI3cOd6?=
 =?us-ascii?Q?LvBCc+KLcMhv7R0ykJMSNPFBcW4i86a0OMXzYec9KK227iPD0LdHT9Gr2zhU?=
 =?us-ascii?Q?fTxv2MLGwBNZtG/4eIlei8cFQgIQkrzjs9MfPLscEu3XSzlwXwLS+y/ObAsx?=
 =?us-ascii?Q?5mdg7iuUyQL5QM7JQcSzQgDUJkMRgI4ZdjCwp2qFwib1asbUkD4+wJJBfFWG?=
 =?us-ascii?Q?k5J5SrGYTjPmXGUJdYY9S+XS6vXERq+BcNBr4pA+3Hfg3tGlN8ncJ3uN/cVs?=
 =?us-ascii?Q?ZHWBPadxZCTrxtKGGcbCx6zzIIQP84/7udcmyc7JnLMvvn7d7FCu7dD8x5CU?=
 =?us-ascii?Q?2xL1VGEMhwBc4J1lAOIiz1PvfIyLT29leMa27zFjJekPYcCvkEZdmaN1KLnE?=
 =?us-ascii?Q?c7J9KcYaCHDICGoJfl47+L9pn9eQgKCgIeryzNqg85MGv4MofaeJqe5BHtz/?=
 =?us-ascii?Q?PTBNLqtrx88JbTtNlIABQylTvpOHlwVxGxNP4bP/CPseUqHvV17O36cqJ5E5?=
 =?us-ascii?Q?/D2tlY3Ktbn6XU5pu0/wVALsOTjXcTA/GhfaV7KelL04+ZVzn2LJtwwoVazd?=
 =?us-ascii?Q?DaGRbyt/kSEk0tjsu3vN+VETrph9Ud2vCG0COBrdK531T3DXEsETdy8+g7KG?=
 =?us-ascii?Q?31goia5zw9sIzGgLYQnZ3yuC6t+hxDHSEYxrHc/oWzR5B9GuetoS2Pr9hJTE?=
 =?us-ascii?Q?ZfymEhcWYIz3bjQXDTE4rQQUQjKPLEDTDUWJtdTP4KDXIJwswcXsCE2wjuzx?=
 =?us-ascii?Q?/zZjCJb9+ODRQ0cN8jHpJDsJ5TNvaDJymzB1ELfIaRfrR/P0cMeoF1gdyOwo?=
 =?us-ascii?Q?qs2YX57etfSa6WQBYFutNhoSmU75PUKpA0EktkajNNNvSnqtO3KdqszzslSv?=
 =?us-ascii?Q?vHCDfb0MMXrLKf0AM5BHMdVXYZbd+jo2Xe4az+P1OOZZ6kcLjTN3zNRvoa/r?=
 =?us-ascii?Q?/fP9xy7frrGooqExzvIWyffK64f/X1XNU/HnZdp9hewjFRdoM2BWO+aGoxzn?=
 =?us-ascii?Q?7h0yOD+vPwEcsajxehsltijW89UALGSL+faBqh/YmgoSkjHQw5noUoZOghWb?=
 =?us-ascii?Q?XEtdQ5cDomupzoWAQACkgv7GJrrDaX0ODuCKAkj0kmqtbIlYshszZMuq+eh6?=
 =?us-ascii?Q?5SyvkGOUXakphzUZxn0Pu6r0W/kxKn+oK9f3Mr/b078spa9eOOBfDT/Tq1+7?=
 =?us-ascii?Q?BQ2e0e7mA3Mvo/sl4puEP9naFdD6snFa/XTFO4qNDb6XNDfdpghbAnoriU1k?=
 =?us-ascii?Q?NvYFjGkgzQj8TYwCFbi/CdRf50GJvYIBQPuEX5A+6v/6iuof//JBj9cjckzT?=
 =?us-ascii?Q?WYc1RdspAmRiAMmYMVb/Q8ahtG5GdMdrEcd0EhK86GaTm5E7sy6DPxbGKpRD?=
 =?us-ascii?Q?ZQ3RcN8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 727c2e80-8d5a-415a-91ce-08d8e9838216
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 20:30:30.1612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XQgCmua2L6AjxYALDWnTcPHCWRJIOsW17L+LdWZpPEiwW6GNrB1c92UzImnIJZkUZBL65cFv+VTPcjENuvOU3mEjJmWLxpR/g2MPLRzapLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1631
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > +	if (!(ms_hyperv.priv_high & HV_ENABLE_EXTENDED_HYPERCALLS))
> > +		return 0;
>=20
> Return 'false' since the function is declared as bool?
Will fix this in the next iteration.

> > +	if (hv_do_hypercall(HV_EXT_CALL_QUERY_CAPABILITIES, NULL, cap) =3D=3D
> > +	    HV_STATUS_SUCCESS)
>=20
> Need to mask before checking for HV_STATUS_SUCCESS.  With regard to the
> reserved fields in the returned 64 bit status, the TLFS says "Callers sho=
uld ignore the
> value in these bits".  There's no promise that they are zero.
Coming in next version.

>=20
> > +		ext_cap =3D *cap;
> > +
> > +	local_irq_restore(flags);
> > +	return ext_cap & cap_query;
> > +}
>=20
> As I noted in a review comment back in May, the output arg here is
> only 64 bits in size and could just live on the stack with assurance that
> it won't cross a page boundary.  So the code could be:
>=20
> bool hv_query_ext_cap(u64 cap_query)
> {
> 	u64	cap;
> 	u64	status;
>=20
> 	if(!(ms_hyperv.priv_high & HV_ENABLE_EXTENDED_HYPERCALLS))
> 		return false;
>=20
> 	status =3D hv_do_hypercall(HV_EXT_CALL_QUERY_CAPABILITIES, NULL, &cap);
> 	if ((status & HV_HYPERCALL_RESULT_MASK) !=3D HV_STATUS_SUCCESS)
> 		cap =3D 0;
>=20
> 	return extcap & cap;
> }
>=20
> But if you think there's value in using the designated page for hypercall=
 args,
> I'm OK with just fixing the testing of the status.

Hypercall input/output addresses should be 'virt_to_phys' compatible as 'hv=
_do_hypercall'
will call that on the address to get the physical address, to pass on to th=
e hypervisor. Stack
variables can be virtually allocated and are not compatible with 'virt_to_p=
hys', but we should
be able to use 'static' variable for this. Will address this in next versio=
n.

>=20
> > -	pr_info("Hyper-V: features 0x%x, hints 0x%x, misc 0x%x\n",
> > -		ms_hyperv.features, ms_hyperv.hints, ms_hyperv.misc_features);
> > +	pr_info("Hyper-V: privilege flags low:0x%x, high:0x%x, hints:0x%x, mi=
sc:0x%x\n",
>=20
> Nit.  Could we just use a space instead of a colon before each of the pri=
nted hex values?
Sure, coming in next version.

> > @@ -23,6 +23,7 @@ config HYPERV_UTILS
> >  config HYPERV_BALLOON
> >  	tristate "Microsoft Hyper-V Balloon driver"
> >  	depends on HYPERV
> > +	select PAGE_REPORTING
>=20
> With this selection made, are the #ifdef CONFIG_PAGE_REPORTING occurrence=
s
> below really needed?  I looked at the virtio balloon driver, which is als=
o does
> "select PAGE_REPORTING", and it does not have any #ifdef's.

Good point. Don't think we need extra 'ifdefs' for page reporting now that =
it is
implicit with Hyper-V Balloon. Coming in next version.

> >  static struct hv_dynmem_device dm_device;
> > @@ -1568,6 +1573,84 @@ static void balloon_onchannelcallback(void *cont=
ext)
> >
> >  }
> >
> > +#ifdef CONFIG_PAGE_REPORTING
> > +/* Hyper-V only supports reporting 2MB pages or higher */
>=20
> I'm guessing the above is the same on ARM64 where the guest is using 16K
> or 64K page size, because Hyper-V always uses 4K pages and expects all gu=
est
> communication to be in units of 4K pages.

Yes.
=20
> > +		range->page.additional_pages =3D
> > +			(sg->length / HV_MIN_PAGE_REPORTING_LEN) - 1;
>=20
> Perhaps verify that sg->length is at least 2 Meg? (similar to verifying t=
hat nents
> isn't too big).  If it isn't at least 2 Meg, then additional_pages will g=
et set to -1,
> and I suspect weird things will happen.
I will add an assert.

>=20
> I was also thinking about whether sg->length could be big enough to overf=
low
> the additional_pages field.  sg->length is an unsigned int, so I don't th=
ink so.
Yes, the additional_pages is designed to accommodate 32-bits.

>=20
> > +		range->base_large_pfn =3D
> > +			page_to_pfn(sg_page(sg)) >> HV_MIN_PAGE_REPORTING_ORDER;
>=20
> page_to_pfn() will do the wrong thing on ARM64 with 16K or 64K pages.
> Use page_to_hvpfn() instead.
Good point.

> > +static void enable_page_reporting(void)
> > +{
> > +	int ret;
> > +
> > +	BUILD_BUG_ON(pageblock_order < HV_MIN_PAGE_REPORTING_ORDER);
>=20
> The BUILD_BUG_ON won't work in the case where pageblock_order is
> actually a variable rather than a constant, though that's currently only =
ia64 and
> powerpc, which we don't directly care about.  Nonetheless, this would bre=
ak if
> pageblock_order were to become a variable.
>=20
I have moved this to a conditional statement. The compiler can optimize the=
 code
away when it is a constant.

> > +	if (ret < 0) {
> > +		dm_device.pr_dev_info.report =3D NULL;
> > +		pr_err("Failed to enable cold memory discard: %d\n", ret);
> > +	} else {
> > +		pr_info("Cold memory discard hint enabled\n");
> > +	}
>=20
> Should the above two messages be prefixed with "Hyper-V: "?
Not needed, as you also replied later.

> Nit:  Typically the error path undoes things in the reverse order. So
> the disable_page_reporting() would occur before the call to
> vmbus_close().
Sure.

>=20
> >  	return ret;
> >  }
> > @@ -1753,6 +1843,9 @@ static int balloon_remove(struct hv_device *dev)
> >  #ifdef CONFIG_MEMORY_HOTPLUG
> >  	unregister_memory_notifier(&hv_memory_nb);
> >  	restore_online_page_callback(&hv_online_page);
> > +#endif
> > +#ifdef CONFIG_PAGE_REPORTING
> > +	disable_page_reporting();
> >  #endif
>=20
> Same here regarding the ordering.
Noted.

> > + * The whole argument should fit in a page to be able to pass to the h=
ypervisor
> > + * in one hypercall.
> > + */
> > +#define HV_MEMORY_HINT_MAX_GPA_PAGE_RANGES  \
> > +	((PAGE_SIZE - sizeof(struct hv_memory_hint)) / \
>=20
> Use HV_HYP_PAGE_SIZE instead of PAGE_SIZE.
Done.

Thanks for the review.

