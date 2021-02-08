Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83404313F6B
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Feb 2021 20:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbhBHTqd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Feb 2021 14:46:33 -0500
Received: from mail-dm6nam11on2095.outbound.protection.outlook.com ([40.107.223.95]:24769
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236295AbhBHTps (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Feb 2021 14:45:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQEHox1Z100EHvnEJqbd2zz2wcmKwhbQMeXZ70rk3rcMPZhPF1qsb1vNfOolfZBN3deRWs/BrvOvlgnpwReaAtjI1PK8V1vZ/H0zk48ZtsYsu9PIDy8HtzdwsOyt9AbnpsjMlNvmN9IHIRpAdW/VUq3k2M80v+fl1PZnTL9BNhMdaIYM64JCi+DQ8llAKKRYYW+QxluIjNHBfw9+r0L4qNuurzYsY/rBOi9POzKOeoFx8edd1f7qJg9B68nsTJ0/c0hlCw5Zv38l7vsu6/9J5cmcsM7JjL93CtykI4+juJ3YvrEyfibpgYGVyKMuMC7v/A1/8ieOgviKjWUsFB+mAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lm0dSXnYGAdJeP52s5oFExT3ACwLmr+bxFzv+O2mB0w=;
 b=JvHP1hpbUZvl6qutklVMkdavLZFjSakM8o3yK+ByDghRtys5NJ+V8sYfjOTTtFfvVgkFEbOkyJpsmrgjasroqOUFHsw1RUrXwpyh9MR6nlI1wD7sVqLUjkaGWlRB2L6SsmyiH4r6czx2M+v7hpC+rMG+xqkS59A6NUDXyp36pPIU8VTNRsHDzh65rnXnxybT2qPjSexiqo1DbwEX1RspceZ2/0ZjUSiAjaeyIaEOJ4FNcHINSSggOuURWoMXsZ0EEPeOE0tkXjaEtopxtBSZAWI5i9Ms1iHCli5epMOLYnkvEYOfhxnssx9MpV49UejuqAIBtp4xIIgpfw/iPWtdtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lm0dSXnYGAdJeP52s5oFExT3ACwLmr+bxFzv+O2mB0w=;
 b=bEhqyjqjsmrVO6x8oPRUe8GRMKQ7T3E+K7q62WxFi+PLm759XTi3b6Ef410Oc9gJIskBgNRu7OqE74WDBG2TvERAziS652NxNzKT3E/nogb71dZ5XU1rnMHYrwOUUj3b397+k43kOb1b+o6KloXfJjBbTz6hSKCP/7QYIcpogDA=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1890.namprd21.prod.outlook.com (2603:10b6:303:64::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.5; Mon, 8 Feb
 2021 19:44:53 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3868.006; Mon, 8 Feb 2021
 19:44:53 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viremana@linux.microsoft.com" <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Lillian Grassin-Drake <Lillian.GrassinDrake@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [RFC PATCH 07/18] virt/mshv: withdraw memory hypercall
Thread-Topic: [RFC PATCH 07/18] virt/mshv: withdraw memory hypercall
Thread-Index: AQHWv52SeVBoeWdMYkyykC9tlZNyGqpL/YpQ
Date:   Mon, 8 Feb 2021 19:44:52 +0000
Message-ID: <MWHPR21MB159305DE956E80D2B45ABA85D78F9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-8-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1605918637-12192-8-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-08T19:44:47Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d3bfc279-fd5c-4a8b-992d-bbc144def86e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linux.microsoft.com; dkim=none (message not signed)
 header.d=none;linux.microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: de4113e3-6ce3-4af9-33aa-08d8cc6a012c
x-ms-traffictypediagnostic: MW4PR21MB1890:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB18902973E4FBE904CD1C4AF5D78F9@MW4PR21MB1890.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dFWv5DDzaFCPm+tZN1rkw1oEkHjpjJ9b/L2hJvKqYys3Gq0IODD3NSRWFNEMrZMrmWi3MNJBi4lNeDPowkGw9fiwq+KGa3tAnf99Ijz6UPq9yjVlFYt0yELVUStTrahUX8Xx2c6J7NoDZlMt6z5kP/5DTvjrkqtqb6g80nZSqZyfsG8VJuhMwG/ov4QK0veaGeaI9HjC0OB63pmbkBAtdEkWmFUSriGvA/14bWwJc/gcVG+YyR26BzDpvtsEG2+Gifpi9QUHMJBbS4Vm7MCZP/UbYCEt51sRikAI+DGIUeujQU8fguC1p2OfVdKd+zFHmjWVjVPiazgxmX1U5Ju+TUHYlMaKlW5iZjoLVhb7DfHDtA2hLrU3BwGkCxQp5g8RruaSAMbn/6LeZ7ZQ4vKmuBRQQ/UdcnjzXdCfWsMY8ReMMdtVKcKyDF7JZGN/1WIoj7CcE574Ku6vFPSrsDTHaKyFb9dYN52QN2lJ7pbnCY4YRQaT4d2DDeSyGFt5GkWV9J8MF28CkMVgn9mJ8qVoVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(66446008)(8990500004)(66476007)(64756008)(186003)(83380400001)(8936002)(66556008)(33656002)(478600001)(2906002)(66946007)(52536014)(82960400001)(76116006)(7696005)(5660300002)(316002)(82950400001)(8676002)(107886003)(9686003)(55016002)(6506007)(110136005)(26005)(71200400001)(4326008)(10290500003)(54906003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3vPn8lQ8fXXd8pNwPEObIBUUGnAVl5eGb0ju1COmK+uTPf/+paI1vQRzaSB3?=
 =?us-ascii?Q?AJ79fTEnXGx935aIp67ZUx/PkwoMkmSUWD3WREP/SJP4u36MDaSnlNV/v869?=
 =?us-ascii?Q?HwCYZ3Pn5PcQNpUcVHmb+QeKqO+DXreeUr2dRuF9dXX6fZVMq6eGX7aDByPR?=
 =?us-ascii?Q?6+iGMpeSnBLjRCeRjBH+zhu/Eom4Up+wElDCkh6dytRHJhpuX9SjSE/z2EGh?=
 =?us-ascii?Q?Mqg+menrx3syB3Q2D0tQvxY5tnu5U3nsPvmpcRuTPUVyAtWUOlPk/6cp2DgE?=
 =?us-ascii?Q?+EvJaOz0svaQgbSPO2xHRK+MYG9u/UUTXcblNgbSnS89Pqzi1l5Vrx2XjQao?=
 =?us-ascii?Q?sVz7SSEEpqHF4oqZedcUDchL+kVt1nY7OBG1TH38G9PjDRFtjivILUi9RUVw?=
 =?us-ascii?Q?zmf/5Qz22bP9sNLtQC8RtaT6Wz9mG1wcURiTmMOLq5s0m4sf0SSluDHZyTlF?=
 =?us-ascii?Q?LK53LQHwjYFXtxWasaJe0nucox9NrPYuldSHaGcY6GB2wJMx3yUquPXYp/qj?=
 =?us-ascii?Q?oCV7lKotUAsnNH5sW2kwr3IWgw/LjK8AkG3vfFuoQAqmD+do6rkPSSkdLrlt?=
 =?us-ascii?Q?LZFu35pGIPLJ/OPKKK8wQOAC7OK9QI/2UvHf05YuC9Kx80ypDg65BTk5Jwg/?=
 =?us-ascii?Q?6q1xuvGqHZ/w24KmzlA7cp48RE3pQV6XwNQcZw+zymfmrBpRrdzhyxTErfRO?=
 =?us-ascii?Q?uTEX9Sr7sfKXDHjqTEGMzzbPHo5kUhy/SfFfVJqDf4GT7G/lr5OhbKPHwWjf?=
 =?us-ascii?Q?Rsg9J6ObVc6lrFaN8vrPzsgxBIP+xKGCIqhS8wCos9UjxwBFzkH3eubPKcIi?=
 =?us-ascii?Q?7DRJ1KYlgMByGm+BCkSUp2D8qPDtwWl+COItFl4i6ztOIDKyR0LwkdCxggGG?=
 =?us-ascii?Q?K9eR/IQ5kbT97GRYNwbzCYW/pJBycnVIf3jaLPZNMXS/zyWYP5BZ2WKFlqvl?=
 =?us-ascii?Q?M3qee7c7Q51ksrOFoxqwl4sgL3i4Z65S6TFqsjtyPNW0kEKGV2LYN8g4WQ/5?=
 =?us-ascii?Q?4zfMMD3QuuECzJXeq37FNkaFOlBWmvLiwttQbL9/u2U4r+YcL/tX2paToMHM?=
 =?us-ascii?Q?ssmue3DroMUnRrKLs+bLVmYPc3JPif+P0V5qLRc3Bpk4TMDYa2UUYkfkiKx1?=
 =?us-ascii?Q?Kdilk3lbTD6YV6LC66I88axXRpipdtklkYreg5e7SQYX4LWfSztC9gR6zgwR?=
 =?us-ascii?Q?sbsmV4cjs0vOCeSCli+EQiIUHQFZ1al5nBvDLU7LrRnRZrYQL5KUSoJx3uhR?=
 =?us-ascii?Q?ksIa/FIatDGIDyVPRPPVpeVGtTZ2FZzyZPTB2ZDoy2k82uv2XUhCi7eI/7b0?=
 =?us-ascii?Q?sGdvbgVIF50ifM/WCZnMX+RV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de4113e3-6ce3-4af9-33aa-08d8cc6a012c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 19:44:52.8400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4+hvta94YWtIHYGehfwurSOwMETKyXtfp9GzFA0f13xJU8NEMPPEGkIeJ1Dl7lAaTn5mk8wXID4chR7ieGGp9sWH0vrEVG7Dx1K/FPLwoZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1890
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, Novem=
ber 20, 2020 4:30 PM
>=20
> Withdraw the memory from a finalized partition and free the pages.
> The partition is now cleaned up correctly when the fd is released.
>=20
> Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  include/asm-generic/hyperv-tlfs.h | 10 ++++++
>  virt/mshv/mshv_main.c             | 54 ++++++++++++++++++++++++++++++-
>  2 files changed, 63 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index ab6ae6c164f5..2a49503b7396 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -148,6 +148,7 @@ struct ms_hyperv_tsc_page {
>  #define HVCALL_DELETE_PARTITION			0x0043
>  #define HVCALL_GET_PARTITION_ID			0x0046
>  #define HVCALL_DEPOSIT_MEMORY			0x0048
> +#define HVCALL_WITHDRAW_MEMORY			0x0049
>  #define HVCALL_CREATE_VP			0x004e
>  #define HVCALL_GET_VP_REGISTERS			0x0050
>  #define HVCALL_SET_VP_REGISTERS			0x0051
> @@ -472,6 +473,15 @@ union hv_proximity_domain_info {
>  	u64 as_uint64;
>  };
>=20
> +struct hv_withdraw_memory_in {
> +	u64 partition_id;
> +	union hv_proximity_domain_info proximity_domain_info;
> +};
> +
> +struct hv_withdraw_memory_out {
> +	u64 gpa_page_list[0];

For a variable size array, the Linux kernel community has an effort
underway to replace occurrences of [0] and [1] with just [].  I think
[] can be used here.

> +};
> +

Add __packed to the above two structs.

>  struct hv_lp_startup_status {
>  	u64 hv_status;
>  	u64 substatus1;
> diff --git a/virt/mshv/mshv_main.c b/virt/mshv/mshv_main.c
> index c4130a6508e5..162a1bb42a4a 100644
> --- a/virt/mshv/mshv_main.c
> +++ b/virt/mshv/mshv_main.c
> @@ -14,6 +14,7 @@
>  #include <linux/slab.h>
>  #include <linux/file.h>
>  #include <linux/anon_inodes.h>
> +#include <linux/mm.h>
>  #include <linux/mshv.h>
>  #include <asm/mshyperv.h>
>=20
> @@ -57,8 +58,58 @@ static struct miscdevice mshv_dev =3D {
>  	.mode =3D 600,
>  };
>=20
> +#define HV_WITHDRAW_BATCH_SIZE	(PAGE_SIZE / sizeof(u64))

Use HV_HYP_PAGE_SIZE so that we're explicit that the dependency
is on the page size used by Hyper-V, which might be different from the
guest page size (at least on architectures like ARM64).

>  #define HV_INIT_PARTITION_DEPOSIT_PAGES 208
>=20
> +static int
> +hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
> +{
> +	struct hv_withdraw_memory_in *input_page;
> +	struct hv_withdraw_memory_out *output_page;
> +	u16 completed;
> +	u64 hypercall_status;
> +	unsigned long remaining =3D count;
> +	int status;
> +	int i;
> +	unsigned long flags;
> +
> +	while (remaining) {
> +		local_irq_save(flags);
> +
> +		input_page =3D (struct hv_withdraw_memory_in *)(*this_cpu_ptr(
> +			hyperv_pcpu_input_arg));
> +		output_page =3D (struct hv_withdraw_memory_out *)(*this_cpu_ptr(
> +			hyperv_pcpu_output_arg));
> +
> +		input_page->partition_id =3D partition_id;
> +		input_page->proximity_domain_info.as_uint64 =3D 0;
> +		hypercall_status =3D hv_do_rep_hypercall(
> +			HVCALL_WITHDRAW_MEMORY,
> +			min(remaining, HV_WITHDRAW_BATCH_SIZE), 0, input_page,
> +			output_page);
> +
> +		completed =3D (hypercall_status & HV_HYPERCALL_REP_COMP_MASK) >>
> +			    HV_HYPERCALL_REP_COMP_OFFSET;
> +
> +		for (i =3D 0; i < completed; i++)
> +			__free_page(pfn_to_page(output_page->gpa_page_list[i]));
> +
> +		local_irq_restore(flags);

Seems like there's some risk that we have interrupts disabled for too long.
We could be calling __free_page() up to 512 times.  It might be better for =
this
function to allocate its own page to be used as the output page, so that in=
terrupts
can be enabled immediately after the hypercall completes.  Then the __free_=
page()
loop can execute with interrupts enabled.   We have the per-cpu input and o=
utput
pages to avoid the overhead of allocating/freeing pages for each hypercall,=
 but in this
case a private output page might be warranted.

> +
> +		status =3D hypercall_status & HV_HYPERCALL_RESULT_MASK;
> +		if (status !=3D HV_STATUS_SUCCESS) {
> +			if (status !=3D HV_STATUS_NO_RESOURCES)
> +				pr_err("%s: %s\n", __func__,
> +				       hv_status_to_string(status));
> +			break;
> +		}
> +
> +		remaining -=3D completed;
> +	}
> +
> +	return -hv_status_to_errno(status);
> +}
> +
>  static int
>  hv_call_create_partition(
>  		u64 flags,
> @@ -230,7 +281,8 @@ destroy_partition(struct mshv_partition *partition)
>=20
>  	/* Deallocates and unmaps everything including vcpus, GPA mappings etc =
*/
>  	hv_call_finalize_partition(partition->id);
> -	/* TODO: Withdraw and free all pages we deposited */
> +	/* Withdraw and free all pages we deposited */
> +	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->id);
>=20
>  	hv_call_delete_partition(partition->id);
>=20
> --
> 2.25.1

