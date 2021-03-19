Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02406342617
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Mar 2021 20:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhCSTVW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 Mar 2021 15:21:22 -0400
Received: from mail-mw2nam10on2131.outbound.protection.outlook.com ([40.107.94.131]:36288
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230476AbhCSTVQ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 Mar 2021 15:21:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWTUT4LwKum78RAKCNb5LjTa/VcGHSFUxFEvJtzHACM/GZqFnFsWxrPZM1aAZ8j+A4cMicSB8K9MafUVdUpS64uQo2rYlsiy/FXGl47bhrqAwya6Na+ylPx7WM3xEnTFbKgcBMFomcj8yG1yyoysEVU7bKfl1W4TyJJee6Y4XBJC2J9T5Nu5OMjhw2Lkc0OcYrhEr4LWaSteXg7kGKQ7ukzQBX2pAsCWRNdOTHulWc54Xgy4M51wooiCOa9L89Tct6gtVuxiVaOoq+MAloi1sHtccPF8qyb1++4mVfM1SIwUc29xsRBJ/NPJZEhZet9/UXsnZ72nYW2JrqAIf7I77Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzIfsYiH1w6xUP/zoVTsxgG2ZIKh4tntUUFI5rlvx2E=;
 b=iSULOnw9nHHFP6UeEDhUlhNsNM91Q6cSt6nT8uiGAciiYEzHcQKfjN2BJFLDdKlk1rRsMOTL82xATdj/3oPLBE+x+2iHNhJ4StgcgruOGIiniehL8qyjgSfL+6BSbuyNT2wY6gidQTDt6oLbv5z0BtNJg3BTzZRXf1t8i4RJRhs81WewugFSvbjOnk+3L5iWdS2CU/NMALA0Z0WbjdYQWQCRgmY5sq0benliEKerIf67FCeoWjVyOPQR9cGJewpZG1rotBYwSWWpZdX1hZsTjstTRqSbBeUqfhR5JP+4tnjxSu2tbkpDgLJMVRQApxw3GEeantuus93ewAkwzGgHJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzIfsYiH1w6xUP/zoVTsxgG2ZIKh4tntUUFI5rlvx2E=;
 b=OR9bZxPX+PcOUds/eTxT4Y0V8oK0+XRmhivDbisFWFwHFYJ29DILVtD0ZZMfpNy8I3TKqIhwCYFhmElRIzFfNNFxbMTbWne7R89n35duBxNavEVbOjYJV5S+K6bkj0lVW/LZczDcq09Ojy+mnnowM5UeW18U6csgjKt3QK3P9kQ=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0158.namprd21.prod.outlook.com (2603:10b6:300:78::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.2; Fri, 19 Mar
 2021 19:21:12 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cbc:735e:a6a5:8b9c]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cbc:735e:a6a5:8b9c%8]) with mapi id 15.20.3977.016; Fri, 19 Mar 2021
 19:21:12 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        Matheus Castello <matheus@castello.eng.br>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, vkuznets <vkuznets@redhat.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] x86/Hyper-V: Support for free page reporting
Thread-Topic: [PATCH v4] x86/Hyper-V: Support for free page reporting
Thread-Index: AdccMlTLMSKb9zjfQ5ekuWl72W2QRgAwfZZQ
Date:   Fri, 19 Mar 2021 19:21:12 +0000
Message-ID: <MWHPR21MB1593BF61E959AC8F056CDFF5D7689@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <SN4PR2101MB088069A91BC5DB6B16C8950BC0699@SN4PR2101MB0880.namprd21.prod.outlook.com>
In-Reply-To: <SN4PR2101MB088069A91BC5DB6B16C8950BC0699@SN4PR2101MB0880.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-19T19:21:10Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=37bbcf07-6dff-414f-9af4-6f29abdf034d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3cac3068-8376-4bdc-cfc0-08d8eb0c28b2
x-ms-traffictypediagnostic: MWHPR21MB0158:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB01587D3FB24097692B2D7CF3D7689@MWHPR21MB0158.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pcVL86VW3vU1kubvbZyYVScIl+PuhhgerVxJN+413/DZpkFlEEeG9O1qmN01hYVD7155IkNYDLeK3pNKdPhWQMC6hctbKCFNW3p2c3z648R+d7SQQe3D3wdQ06HaQMSWk6Rf/XYntwZNlkCklHR16gHmDe9e4DcbKWKz22psjPqwP+nl9r9pcFcj7UMsj+VInrojtVNqtyHEwmGRmlbpWzucuygdq7JP36Mq/oXgQrXNJf79VPzX8nB6UnQnSRbNkxTA9hCH5D6dtVvxibYXemYuR3NrwJ6VUXXVEvDWSyNIbP+Ku9TszBu00U9Ma3FYP1JaJS2llNjpSShzoGUiSCNESGgYMblnqK0xgAhLetK3rcq2E+mCBU6SEHxeBw73pcl6H2iZcL3DY1cm1HcwG0qPtLmna5e/esNPUnwS3ACMSS1oOjBPsIwIh8cfedYabbzomkY0l+N0jMKEelVJ0BHSlnyaI4T5tLKiRMel+6ONzEYftYgCezCnv0JgC3OK7R1oZSfDmn0ecCY9nx6HaH+952/es5qrpnuhw0wLcSnqA/6JTOLPXC8p/dHV3gfJ0BsY0Hi4OMmPL43vth7z+4r56/bpQby6JfvSLattm0rgqjUl6WP78+ZL6GDuhNycFnlCokZDFAaP/FbwVPxD5iSC6TL7L8fkrpDIVxE7qQW4hN3KH26e07iBZOH/rFYn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(5660300002)(82950400001)(8990500004)(6506007)(9686003)(82960400001)(76116006)(66476007)(8676002)(186003)(26005)(86362001)(66946007)(8936002)(52536014)(55016002)(316002)(66556008)(64756008)(66446008)(54906003)(4326008)(10290500003)(38100700001)(71200400001)(2906002)(83380400001)(7696005)(33656002)(478600001)(110136005)(21314003)(4533004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Hjg0xu7VTf22TSmgI2pBU4ScDLjo/SS/H0ot3RofzTyqjo8aEkN03ynruygj?=
 =?us-ascii?Q?mBqHDyBudAoNvCk5nXfg0MVQbbGFqG2/UiOR/zjAaSROk+B/VUtrawfAariy?=
 =?us-ascii?Q?L16c23B8HPcBxpNWkYjWT8hvICG9sHtFzvD415FTi4yIhCkkrx1iZlFUYcvs?=
 =?us-ascii?Q?8qgyts5cupjUgk/6IIrLcxxu7MgQ0WOox4D90Tsr9ViDqtN2FyWMHb0I1w0G?=
 =?us-ascii?Q?/diFpGAj6ru7XpbNUDqBhV/LRAUJHJfc6gno6oPeG13RzEZOjPugQ21HF/FZ?=
 =?us-ascii?Q?tLjHVbXT5XG8LuxgLQCZFBbRMPFAtHjgembB0OWBfQBbaJUJv0A0a3bNhy77?=
 =?us-ascii?Q?WzaWGMHM2FQLnPESQTlkN/PcmryRWcYXnNVSjT1RmNbahxsfXJXgkvMcJxkz?=
 =?us-ascii?Q?P7Z3DIaP8u6Jt9JAkFYBbyTJVWcXYTknc7vzxJgiHYNOVxaCLrWjUdEg14YE?=
 =?us-ascii?Q?LDN3CfDPX4XCg677Na7NCDlkvOMRAw5myOST/I4l6mFwFmlrtcxwdnSkgUrC?=
 =?us-ascii?Q?oHnUQUo4h5R/qT7dK6s9Sms+euwza61GHNAImd7radLO0HZ3KFAztZ1Ap+WI?=
 =?us-ascii?Q?k5Kf8Nt4SrzuSXAp6iw8LZnQkbh90eiJ4+azW76OE6dtXU/rVXa6gOh29tOg?=
 =?us-ascii?Q?yonsk8KcS9UJbFJXsPjNTV1do/AqEmiA0XSmZ4TChCsHDmqr+6bTtxyPYwpj?=
 =?us-ascii?Q?8LJx8D6iiYuf0UcBbfk8NModvcJOsgs8PNyhIiYIjcmzylSibs6cO1iaiWJA?=
 =?us-ascii?Q?ME2hKHsffLu+KADJw0/mQy7C7lWd/SHnnGi4dnOlIHXVNqbe/zTqPbsW14fT?=
 =?us-ascii?Q?0OCCzwWFIVc3bErOj7js0D/rx7caUgBc7UUCnOsWYu8SgrROy/hycjEG3Q2i?=
 =?us-ascii?Q?oU530vL2NIO8Had3X/nE0nMKAm5806p8ssNMGP+NrXjXzQ7Al+sbySAny2IH?=
 =?us-ascii?Q?d3jfJndNIu91HtZqqFuK+w2X8yb5csO3bjHLh79POM3KxO6q44zWss/+ZE+w?=
 =?us-ascii?Q?mJoPssypC4Bdn8SFKRa6jZ4qcAC7Ro+YAEP7hF3SWmYCD9PdgXaz4xoCVovl?=
 =?us-ascii?Q?CkyV1sOBLzoXzSOmVDiMnU2S7LJ1FaB7pund8GZT77ut+3nBQ9vgzOuYRfHf?=
 =?us-ascii?Q?LXzV2q3/zSY7kEklLJUEwqAexbQbPWiA2VBsgpFx6GEICVpWR6jZKdKMKFW3?=
 =?us-ascii?Q?/X5hmFTmoVmKk+OeyW6ueTEoQ60J3BeeW2qDESKApBG2NpcVjs5GDcldWkk4?=
 =?us-ascii?Q?rixokkXJe3rFqZLCnG2fUlnrBAfY+t2an5Lzv75sCI3VLgcEyjrTaNflnqPY?=
 =?us-ascii?Q?1FOshsvAAY6dpe6KQ1CMXKSe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cac3068-8376-4bdc-cfc0-08d8eb0c28b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 19:21:12.6837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRFmcJUlOJuWjcU8n4XOR+dN8mBZSlhiCpi9rb4GnQc7qJQMJYo0eAEK2j+IXn4aUs6mo2cyUbca4n2DCBe2t429RnQ20UW9NA3meOEl5/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0158
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@microsoft.com> Sent: Thursday, March 18, 2=
021 1:14 PM
>=20
> Linux has support for free page reporting now (36e66c554b5c) for
> virtualized environment. On Hyper-V when virtually backed VMs are
> configured, Hyper-V will advertise cold memory discard capability,
> when supported. This patch adds the support to hook into the free
> page reporting infrastructure and leverage the Hyper-V cold memory
> discard hint hypercall to report/free these pages back to the host.
>=20
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Tested-by: Matheus Castello <matheus@castello.eng.br>
> ---
> In V2:
> - Addressed feedback comments
> - Added page reporting config option tied to hyper-v balloon config
>=20
> In V3:
> - Addressed feedback from Vitaly
>=20
> In V4:
> - Queried and cached the Hyper-V extended capability for the lifetime
>   of the VM
> - Addressed feedback from Michael Kelley.
> ---
>  arch/x86/hyperv/hv_init.c         | 45 +++++++++++++++-
>  arch/x86/kernel/cpu/mshyperv.c    |  9 ++--
>  drivers/hv/Kconfig                |  1 +
>  drivers/hv/hv_balloon.c           | 89 +++++++++++++++++++++++++++++++
>  include/asm-generic/hyperv-tlfs.h | 35 +++++++++++-
>  include/asm-generic/mshyperv.h    |  3 +-
>  6 files changed, 174 insertions(+), 8 deletions(-)
>=20

[snip]

> +/* Bit mask of the extended capability to query: see HV_EXT_CAPABILITY_x=
xx */
> +bool hv_query_ext_cap(u64 cap_query)
> +{
> +	/*
> +	 * The address of the 'hv_extended_cap' variable will be used as an
> +	 * output parameter to the hypercall below and so it should be
> +	 * compatible with 'virt_to_phys'. Which means, it's address should be
> +	 * directly mapped. Use 'static' to keep it compatible; stack variables
> +	 * can be virtually mapped, making them imcompatible with
> +	 * 'virt_to_phys'.
> +	 * Hypercall input/output addresses should also be 8-byte aligned.
> +	 */
> +	static u64 hv_extended_cap __aligned(8);
> +	static bool hv_extended_cap_queried;
> +	u64 status;
> +
> +	/*
> +	 * Querying extended capabilities is an extended hypercall. Check if th=
e
> +	 * partition supports extended hypercall, first.
> +	 */
> +	if (!(ms_hyperv.priv_high & HV_ENABLE_EXTENDED_HYPERCALLS))
> +		return false;
> +
> +	/* Extended capabilities do not change at runtime. */
> +	if (hv_extended_cap_queried)
> +		return hv_extended_cap & cap_query;
> +
> +	status =3D hv_do_hypercall(HV_EXT_CALL_QUERY_CAPABILITIES, NULL,
> +				 &hv_extended_cap);
> +	hv_extended_cap_queried =3D true;

What's the strategy for this flag in the unlikely event that the hypercall =
fails?
It doesn't seem right to have hv_query_ext_cap() fail, but leave the
static flag set to true.  Just move that line down to after the status chec=
k
has succeeded?

> +	status &=3D HV_HYPERCALL_RESULT_MASK;
> +	if (status !=3D HV_STATUS_SUCCESS) {
> +		pr_err("Hyper-V: Extended query capabilities hypercall failed 0x%llx\n=
",
> +		       status);
> +		return false;
> +	}
> +
> +	return hv_extended_cap & cap_query;
> +}
> +EXPORT_SYMBOL_GPL(hv_query_ext_cap);

Other than the above about the flag when the hypercall fails,
everything else looks good.

Michael
