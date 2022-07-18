Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855F85788A7
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Jul 2022 19:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbiGRRmE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 18 Jul 2022 13:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiGRRmD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 18 Jul 2022 13:42:03 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2091.outbound.protection.outlook.com [40.107.243.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23692D1CA;
        Mon, 18 Jul 2022 10:42:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYknFnlT5wtHHbL6lt/NIBAu9N8Z44DlzUx4y+46KHWxvV4NN46eXUyL5m4/yLlRnadgIKQPlknOOoEP5vjhuBMsTBHLEjTZWnTkQAJ3Ynbs3hJNEW7vE4ksj0ei80Jna12zMsF08BG06+u9VQk6QDAjJetST7rh/GYzGHOLHVsRRpjhTX1sPH2I09EHCm0lwhUyZgmSH0M2CZlsjvdXTktQ6LDlf/SNUQRy23+yr5eV40XLXEDo/fBsZTj99bKweNmenlYEF8HMI8vPMqmiH6fa4/tMx6vKCWrlFYBcybohmuaR0J5WTysWOVec4DiucJx3aAyV+u7jD3gS9W60WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCNY9xhEZvNOvSQ+97B1v41WD2Y7VJk8HebWSW7mG28=;
 b=EC9p4ZZicw6iYjOBdxOG6CRtCXFauyBVoLRSPUH+Id9bOoI8ZYjUsenWpfv3kjaUM2wOKjH84Z5Vrvm/5c3sHsJyqiOGS37OBVqgr7OAj9fCvZFTiHmYHBQQYad65Vc80KmDViHO0TVI3PMmST5nS1P/MEoyn2gjWXeR4z4NI/LKHYSKyR0eyX10g4IJ/LCQHrBR8KcEnCJXO3nRrpV3hjVOLiS0kzvpGiRJjoKMbUga02t15vijrQra/F7Aata6dqAY7KK0fvBI/NJb5FdLiaUkBkN8LyWOAECKyOdJt7q0zc157TlE4Vi802eM3ZCsaGcHcam38Sj/GmIrSgAgNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCNY9xhEZvNOvSQ+97B1v41WD2Y7VJk8HebWSW7mG28=;
 b=PzgSjrcPaUWBm6HgTBqGhntWPLhFpzg+FAp5x1OOwtThnlrS/wd41Ybbmnr9YzYzVf90KmhvVk/EBcV/4nRcUJ7Pi+8lzOSr8o0wdySSiI3HTu3RFEtk8jRyCThiP/0idQwKjXBlB2MlHHNzNhccwsWRFuedb2GlKknnU7Q3/SE=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by MN2PR21MB1406.namprd21.prod.outlook.com (2603:10b6:208:20b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.1; Mon, 18 Jul
 2022 17:41:58 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ddda:3701:dfb8:6743]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ddda:3701:dfb8:6743%4]) with mapi id 15.20.5482.001; Mon, 18 Jul 2022
 17:41:58 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "hch@infradead.org" <hch@infradead.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        KY Srinivasan <kys@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "kirill.shutemov@intel.com" <kirill.shutemov@intel.com>,
        "andi.kleen@intel.com" <andi.kleen@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: RE: [PATCH V4] swiotlb: Split up single swiotlb lock
Thread-Topic: [PATCH V4] swiotlb: Split up single swiotlb lock
Thread-Index: AQHYkuX+LIPeIW/vGkSqRRlKgLssAa2EbH+A
Date:   Mon, 18 Jul 2022 17:41:58 +0000
Message-ID: <PH0PR21MB3025C32C80BFBE8651CF196AD78C9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220708161544.522312-1-ltykernel@gmail.com>
In-Reply-To: <20220708161544.522312-1-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=436848f8-61cc-479a-9f9f-91c0e6aa4fba;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-07-18T17:09:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48ad6b2b-6d2c-4022-8ffa-08da68e4d050
x-ms-traffictypediagnostic: MN2PR21MB1406:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2PwtgYA5owHtlKF0yQhHNkHg4BOyyIUhn/DgKKOzP5IYtDNG0E/F0S5AJJrfPXT8aRimL03/PfTkTbBZUowlC6yDhgX+WopvPO+oRzbh0w0f/wWNeVaU061vQjpW4onISm70XD8VmAHHsOYTXpSQXgHUzl+aI9mKlwvnkwilPqc3bpnFi2dYUEcqzVyTpFs8SEa2PPUh7fmpvm0yne4/7FxuZxr7BrJjjWG7Rv/xIrRpFen5A3UftgzmGvlzNrDxC6NtG9LZLYfgOxxTm0EZLYAvBZ5VZvWctSYkTIdarw4WOkLWLmwnt1WDOBtN/fyQ7Uye2/n3E2MMx0GLAeltT/DE2ZAxFXEHe0VPeW+1AXdmJCY1HweKQ/y0iPF+MzyGNstxMP0HbZBbGzd3bqy+L3XJFed5AOwykEQgyeM3VoaXQcBUeGzcFhRjmmwQp68Ip7uLhs7NINNxeCDqJZRziNG98YKXK6h4Db2s2bpWvYPfJ1FTCN7/Zye42Rlu6KVvg017PNNiawiKP5fgfz7OY4IQy0QX+hobWxb4VztlTj4/uETIVQIKP3TZMOYWynn8X9hgm2GGu+9o9yyAttO1naXcNBZ6Eydy995ueWy8viMQjqqsendej9wYI9QrNssssaZh+l8ikUa29yBp7FPv2ODpB/3Orv6Xv+qtKgjYhL93h/fmZEBO5/Xn0I55WQ/zsRjhvcyd3ehJfLkj3uRYzPtBEUuXuOsYEoGD7iV2SDDEXmieRdQ9fQHtws8mdFrPNSgkQ1/rK8zQpkepS1Pj3B2Q/Z29CbU/62V8LLWZhutJXFmRTkkUwKkBRxvGMXbXbnxvY2WEfrQzskhJpkQSY1Y/AO9VNDveYCa7xtNx2RK4D4szWkxLoX80BwAydtqeOun4dLYvc8m2ptF1COAtmM12rAYH86pmc8M5tYrd8U4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199009)(64756008)(41300700001)(8676002)(66446008)(4326008)(5660300002)(66946007)(86362001)(6636002)(2906002)(110136005)(10290500003)(71200400001)(55016003)(54906003)(30864003)(7416002)(66476007)(66556008)(52536014)(478600001)(316002)(8936002)(6506007)(8990500004)(186003)(33656002)(7696005)(26005)(9686003)(82960400001)(38070700005)(76116006)(921005)(83380400001)(82950400001)(122000001)(38100700002)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7zFsdKMrjrBFA8mZNBuil9kd9+zWjGIJ/7NMuSsEKK0OhtdeXChOXmSZfp7U?=
 =?us-ascii?Q?ZwYBUX++Jwc9A2oWYMC5hYcvW3sMJpZWXwiB/l9viXkVUlHm2eDGgiDPJiMT?=
 =?us-ascii?Q?0436bNNDEXOUXfWrZeKD3fINIkkaWmyZwgY45JAly9O3IxQmLNwtcKm5FUeH?=
 =?us-ascii?Q?k2bTq3f/qSSluEMrwnJxiFVww3AJo23nrp00WcYMQFTD7lDaLjWIJ2rMRIAn?=
 =?us-ascii?Q?I7bu2TjYEvBnUY+aMnr4omeX0dymBEGgR5FLUs0MrUl4mC1W6QlwZQdXB671?=
 =?us-ascii?Q?97990JdLXSmbFSCcrZRDPo6jyrGDCSGg9DaaYgWsFMYdcYesS0hubSG2HHd9?=
 =?us-ascii?Q?ZbN+KhzM75RMesL8q69z7qJpDhYQyfXbZ8WkcxbcmEvepNfhXP027qa6JJ3k?=
 =?us-ascii?Q?yEdyEh7GNEngYRHOawLCzV76tCDRjjTj+ukN52f6Hp92V7Gu/JtJGIcGIET9?=
 =?us-ascii?Q?HuSpKMS+3u1JiKH5XdlA8Nd3DI2My4BGYjDihbt7/9H7pvz8z6on+65DYEUe?=
 =?us-ascii?Q?qFTBii0G0eqrOREjbqJF8UYHOIXCigcnlyPgn+JyWOLhfR6+Mk/vYFwtJq12?=
 =?us-ascii?Q?fsbNpNdj5xKPL3gSdT3PUrEKsTLcI2N5V1q72tPmFnmn/dVvFBb5WsJkT1jT?=
 =?us-ascii?Q?SQRUK//rvchWLSIeCNST8wVbQgZHfGZjwrSGv83WqFBik9DKVwxQuwq6fWRE?=
 =?us-ascii?Q?OAy985zVA+ddnLxiF7qFBo7V34sBULxymdaqSPlx+cgpszDr5qLx/nl6ZZ1I?=
 =?us-ascii?Q?FeiSaTaq5kzuQtPRb+oGbiRzjiA1vOSTXwbewuDGXvF/mC+l+aj39RDOwilb?=
 =?us-ascii?Q?ilOU/j9/kUSFsEEWBjqy7LhmDd+Lx8x7iwTw/SIpPR88J/eEY8ZhqpcG8xKf?=
 =?us-ascii?Q?PWiqJJMETq3VNSuGn+ENe+87v27ftAXNY8ezQxcyx3iKfJ+HIO/+ca22o2A8?=
 =?us-ascii?Q?Gj36QJM5c7UIWqUCEtRqgIDd45Iz38lraZCQjx4Enw4GcZHtTbsKvivIXGBW?=
 =?us-ascii?Q?HuwNY3/hqXZ5SmeerdmULJuw031JLF4fx0JXxva/3xd0v+hUAFoRMTCoxhjn?=
 =?us-ascii?Q?G5wUPC9JUhUxd5hWF07bo6fPc+xp3wEXpBit7jY8CiIURdZNcQRdI+eTKYeZ?=
 =?us-ascii?Q?+oqjNtdlb3M+3NYu0BNBHf4fsXLKmgtLiI5IvAnF4cI2z27F3CMbAY+/MwoT?=
 =?us-ascii?Q?mD4SWMB7kK9vsxD0/0INbh/joeBOn/59884MjwF+sTPmDCEl3dXBsunNI3A0?=
 =?us-ascii?Q?gA8H/vfzrbUmGDC/sb6HX2upFp8zxYCSsULsGJuvXs2LAh5x6OKI/O5CjrF8?=
 =?us-ascii?Q?gU07+4WAgUXBLO50TSg/BAPSI5zs6ePCpg0Zd3+lpFYHGFjGjl24AnPPgFss?=
 =?us-ascii?Q?ApE4CRLQamn8mwpoowNV+F+nZZAUxRGe9ZWry+yFS21w7lRM8ImySwro45Jm?=
 =?us-ascii?Q?vQ/NB15X13hStESZ0pSRC4jJxasu/ImuKQgtw4vO/osWayNW1xq2rn8R5JtI?=
 =?us-ascii?Q?RqDYoT4trFoKfzAY/biunD3s5QO8RjvR5HY7YLB/bI+FmIbSift6toT7U7I8?=
 =?us-ascii?Q?XnUKRsa5Nov+ifuynHv6Lb56LuvQCUEVvZsDJVmYdSqQFAlq69+/uA+h/XMX?=
 =?us-ascii?Q?ng=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ad6b2b-6d2c-4022-8ffa-08da68e4d050
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 17:41:58.2964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OBNH4M+CTSJIrUnqhSTDFxrsbozLVraUAK4B6GIJTVOG+jK+4zRLHczBXYBJhlHjH7szJJYUqvxyyq3no8MMpIMrcuNsp6x5eoI8RxX+bJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1406
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Friday, July 8, 2022 9:16 AM
>=20
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>=20
> Traditionally swiotlb was not performance critical because it was only
> used for slow devices. But in some setups, like TDX/SEV confidential
> guests, all IO has to go through swiotlb. Currently swiotlb only has a
> single lock. Under high IO load with multiple CPUs this can lead to
> significat lock contention on the swiotlb lock.
>=20
> This patch splits the swiotlb bounce buffer pool into individual areas
> which have their own lock. Each CPU tries to allocate in its own area
> first. Only if that fails does it search other areas. On freeing the
> allocation is freed into the area where the memory was originally
> allocated from.
>=20
> Area number can be set via swiotlb kernel parameter and is default
> to be possible cpu number. If possible cpu number is not power of
> 2, area number will be round up to the next power of 2.
>=20
> This idea from Andi Kleen
> patch (https://github.com/intel/tdx/commit/master=20
> 4529b5784c141782c72ec9bd9a92df2b68cb7d45).
>=20
> Based-on-idea-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
> Change sicne v3:
>        * Make area number to be zero by default
>=20
> Change since v2:
>        * Use possible cpu number to adjust iotlb area number
>=20
> Change since v1:
>        * Move struct io_tlb_area to swiotlb.c
>        * Fix some coding style issue.

I apologize for being late to the party, but I've spotted a couple of
things that are minor bugs and I have a few nit-picky comments.

> ---
>  .../admin-guide/kernel-parameters.txt         |   4 +-
>  include/linux/swiotlb.h                       |   5 +
>  kernel/dma/swiotlb.c                          | 230 +++++++++++++++---
>  3 files changed, 198 insertions(+), 41 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt
> index 2522b11e593f..4a6ad177d4b8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5904,8 +5904,10 @@
>  			it if 0 is given (See Documentation/admin-guide/cgroup-v1/memory.rst)
>=20
>  	swiotlb=3D	[ARM,IA-64,PPC,MIPS,X86]
> -			Format: { <int> | force | noforce }
> +			Format: { <int> [,<int>] | force | noforce }
>  			<int> -- Number of I/O TLB slabs
> +			<int> -- Second integer after comma. Number of swiotlb
> +				 areas with their own lock. Must be power of 2.

Rather than "Must be power of 2" it would be more accurate to
say "Will be rounded up to a power of 2".

>  			force -- force using of bounce buffers even if they
>  			         wouldn't be automatically used by the kernel
>  			noforce -- Never use bounce buffers (for debugging)
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 7ed35dd3de6e..5f898c5e9f19 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -89,6 +89,8 @@ extern enum swiotlb_force swiotlb_force;
>   * @late_alloc:	%true if allocated using the page allocator
>   * @force_bounce: %true if swiotlb bouncing is forced
>   * @for_alloc:  %true if the pool is used for memory allocation
> + * @nareas:  The area number in the pool.
> + * @area_nslabs: The slot number in the area.
>   */
>  struct io_tlb_mem {
>  	phys_addr_t start;
> @@ -102,6 +104,9 @@ struct io_tlb_mem {
>  	bool late_alloc;
>  	bool force_bounce;
>  	bool for_alloc;
> +	unsigned int nareas;
> +	unsigned int area_nslabs;
> +	struct io_tlb_area *areas;
>  	struct io_tlb_slot {
>  		phys_addr_t orig_addr;
>  		size_t alloc_size;
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index cb50f8d38360..9f547d8ab550 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -70,6 +70,43 @@ struct io_tlb_mem io_tlb_default_mem;
>  phys_addr_t swiotlb_unencrypted_base;
>=20
>  static unsigned long default_nslabs =3D IO_TLB_DEFAULT_SIZE >> IO_TLB_SH=
IFT;
> +static unsigned long default_nareas;
> +
> +/**
> + * struct io_tlb_area - IO TLB memory area descriptor
> + *
> + * This is a single area with a single lock.
> + *
> + * @used:	The number of used IO TLB block.
> + * @index:	The slot index to start searching in this area for next round=
.
> + * @lock:	The lock to protect the above data structures in the map and
> + *		unmap calls.
> + */
> +struct io_tlb_area {
> +	unsigned long used;

I didn't see this field getting initialized anywhere.  'index' and
'lock' are initialized in swiotlb_init_io_tlb_mem(), but not 'used'.
From what I can tell, memblock_alloc() doesn't zero the memory.

> +	unsigned int index;
> +	spinlock_t lock;
> +};
> +
> +static void swiotlb_adjust_nareas(unsigned int nareas)
> +{
> +	if (!is_power_of_2(nareas))
> +		nareas =3D roundup_pow_of_two(nareas);

If the swiotlb=3D boot line option specifies "0" as the number
of areas, is_power_of_2() will return false, and
roundup_pow_of_two() will be called with an input
argument of 0, the results of which are undefined. =20

> +
> +	default_nareas =3D nareas;
> +
> +	pr_info("area num %d.\n", nareas);
> +	/*
> +	 * Round up number of slabs to the next power of 2.
> +	 * The last area is going be smaller than the rest if
> +	 * default_nslabs is not power of two.
> +	 */
> +	if (nareas && !is_power_of_2(default_nslabs)) {
> +		default_nslabs =3D roundup_pow_of_two(default_nslabs);
> +		pr_info("SWIOTLB bounce buffer size roundup to %luMB",
> +			(default_nslabs << IO_TLB_SHIFT) >> 20);
> +	}
> +}
>=20
>  static int __init
>  setup_io_tlb_npages(char *str)
> @@ -79,6 +116,10 @@ setup_io_tlb_npages(char *str)
>  		default_nslabs =3D
>  			ALIGN(simple_strtoul(str, &str, 0), IO_TLB_SEGSIZE);
>  	}
> +	if (*str =3D=3D ',')
> +		++str;
> +	if (isdigit(*str))
> +		swiotlb_adjust_nareas(simple_strtoul(str, &str, 0));
>  	if (*str =3D=3D ',')
>  		++str;
>  	if (!strcmp(str, "force"))
> @@ -112,8 +153,19 @@ void __init swiotlb_adjust_size(unsigned long size)
>  	 */
>  	if (default_nslabs !=3D IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT)
>  		return;
> +
> +	/*
> +	 * Round up number of slabs to the next power of 2.
> +	 * The last area is going be smaller than the rest if
> +	 * default_nslabs is not power of two.
> +	 */
>  	size =3D ALIGN(size, IO_TLB_SIZE);
>  	default_nslabs =3D ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
> +	if (default_nareas) {
> +		default_nslabs =3D roundup_pow_of_two(default_nslabs);
> +		size =3D default_nslabs << IO_TLB_SHIFT;
> +	}
> +
>  	pr_info("SWIOTLB bounce buffer size adjusted to %luMB", size >> 20);
>  }
>=20
> @@ -192,7 +244,8 @@ void __init swiotlb_update_mem_attributes(void)
>  }
>=20
>  static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t =
start,
> -		unsigned long nslabs, unsigned int flags, bool late_alloc)
> +		unsigned long nslabs, unsigned int flags,
> +		bool late_alloc, unsigned int nareas)
>  {
>  	void *vaddr =3D phys_to_virt(start);
>  	unsigned long bytes =3D nslabs << IO_TLB_SHIFT, i;
> @@ -202,10 +255,17 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_m=
em *mem, phys_addr_t start,
>  	mem->end =3D mem->start + bytes;
>  	mem->index =3D 0;
>  	mem->late_alloc =3D late_alloc;
> +	mem->nareas =3D nareas;
> +	mem->area_nslabs =3D nslabs / mem->nareas;
>=20
>  	mem->force_bounce =3D swiotlb_force_bounce || (flags & SWIOTLB_FORCE);
>=20
>  	spin_lock_init(&mem->lock);
> +	for (i =3D 0; i < mem->nareas; i++) {
> +		spin_lock_init(&mem->areas[i].lock);
> +		mem->areas[i].index =3D 0;
> +	}
> +
>  	for (i =3D 0; i < mem->nslabs; i++) {
>  		mem->slots[i].list =3D IO_TLB_SEGSIZE - io_tlb_offset(i);
>  		mem->slots[i].orig_addr =3D INVALID_PHYS_ADDR;
> @@ -232,7 +292,7 @@ void __init swiotlb_init_remap(bool addressing_limit,=
 unsigned int flags,
>  		int (*remap)(void *tlb, unsigned long nslabs))
>  {
>  	struct io_tlb_mem *mem =3D &io_tlb_default_mem;
> -	unsigned long nslabs =3D default_nslabs;
> +	unsigned long nslabs;
>  	size_t alloc_size;
>  	size_t bytes;
>  	void *tlb;
> @@ -242,6 +302,15 @@ void __init swiotlb_init_remap(bool addressing_limit=
, unsigned int flags,
>  	if (swiotlb_force_disable)
>  		return;
>=20
> +	/*
> +	 * default_nslabs maybe changed when adjust area number.
> +	 * So allocate bounce buffer after adjusting area number.
> +	 */
> +	if (!default_nareas)
> +		swiotlb_adjust_nareas(num_possible_cpus());
> +
> +	nslabs =3D default_nslabs;
> +
>  	/*
>  	 * By default allocate the bounce buffer memory from low memory, but
>  	 * allow to pick a location everywhere for hypervisors with guest
> @@ -274,7 +343,13 @@ void __init swiotlb_init_remap(bool addressing_limit=
, unsigned int flags,
>  		panic("%s: Failed to allocate %zu bytes align=3D0x%lx\n",
>  		      __func__, alloc_size, PAGE_SIZE);
>=20
> -	swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, flags, false);
> +	mem->areas =3D memblock_alloc(sizeof(struct io_tlb_area) *
> +		default_nareas, SMP_CACHE_BYTES);

The size to allocate is open coded here, whereas swiotlb_init_late()
uses array_size().  Any reason for the difference?

> +	if (!mem->areas)
> +		panic("%s: Failed to allocate mem->areas.\n", __func__);
> +
> +	swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, flags, false,
> +				default_nareas);
>=20
>  	if (flags & SWIOTLB_VERBOSE)
>  		swiotlb_print_info();
> @@ -296,7 +371,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  	struct io_tlb_mem *mem =3D &io_tlb_default_mem;
>  	unsigned long nslabs =3D ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
>  	unsigned char *vstart =3D NULL;
> -	unsigned int order;
> +	unsigned int order, area_order;
>  	bool retried =3D false;
>  	int rc =3D 0;
>=20
> @@ -337,19 +412,34 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  			(PAGE_SIZE << order) >> 20);
>  	}
>=20
> +	if (!default_nareas)
> +		swiotlb_adjust_nareas(num_possible_cpus());
> +
> +	area_order =3D get_order(array_size(sizeof(*mem->areas),
> +		default_nareas));

See above comment about array_size() vs. open coding.

> +	mem->areas =3D (struct io_tlb_area *)
> +		__get_free_pages(GFP_KERNEL | __GFP_ZERO, area_order);
> +	if (!mem->areas)
> +		goto error_area;
> +
>  	mem->slots =3D (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
>  		get_order(array_size(sizeof(*mem->slots), nslabs)));
> -	if (!mem->slots) {
> -		free_pages((unsigned long)vstart, order);
> -		return -ENOMEM;
> -	}
> +	if (!mem->slots)
> +		goto error_slots;
>=20
>  	set_memory_decrypted((unsigned long)vstart,
>  			     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
> -	swiotlb_init_io_tlb_mem(mem, virt_to_phys(vstart), nslabs, 0, true);
> +	swiotlb_init_io_tlb_mem(mem, virt_to_phys(vstart), nslabs, 0, true,
> +				default_nareas);
>=20
>  	swiotlb_print_info();
>  	return 0;
> +
> +error_slots:
> +	free_pages((unsigned long)mem->areas, area_order);
> +error_area:
> +	free_pages((unsigned long)vstart, order);
> +	return -ENOMEM;
>  }
>=20
>  void __init swiotlb_exit(void)
> @@ -357,6 +447,7 @@ void __init swiotlb_exit(void)
>  	struct io_tlb_mem *mem =3D &io_tlb_default_mem;
>  	unsigned long tbl_vaddr;
>  	size_t tbl_size, slots_size;
> +	unsigned int area_order;
>=20
>  	if (swiotlb_force_bounce)
>  		return;
> @@ -371,9 +462,14 @@ void __init swiotlb_exit(void)
>=20
>  	set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT);
>  	if (mem->late_alloc) {
> +		area_order =3D get_order(array_size(sizeof(*mem->areas),
> +			mem->nareas));
> +		free_pages((unsigned long)mem->areas, area_order);
>  		free_pages(tbl_vaddr, get_order(tbl_size));
>  		free_pages((unsigned long)mem->slots, get_order(slots_size));
>  	} else {
> +		memblock_free_late(__pa(mem->areas),
> +				   mem->nareas * sizeof(struct io_tlb_area));

Open coding vs. array_size() difference is here as well.

>  		memblock_free_late(mem->start, tbl_size);
>  		memblock_free_late(__pa(mem->slots), slots_size);
>  	}
> @@ -476,9 +572,9 @@ static inline unsigned long get_max_slots(unsigned lo=
ng boundary_mask)
>  	return nr_slots(boundary_mask + 1);
>  }
>=20
> -static unsigned int wrap_index(struct io_tlb_mem *mem, unsigned int inde=
x)
> +static unsigned int wrap_area_index(struct io_tlb_mem *mem, unsigned int=
 index)
>  {
> -	if (index >=3D mem->nslabs)
> +	if (index >=3D mem->area_nslabs)
>  		return 0;
>  	return index;
>  }
> @@ -487,10 +583,11 @@ static unsigned int wrap_index(struct io_tlb_mem *m=
em,
> unsigned int index)
>   * Find a suitable number of IO TLB entries size that will fit this requ=
est and
>   * allocate a buffer from that IO TLB pool.
>   */
> -static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
> -			      size_t alloc_size, unsigned int alloc_align_mask)
> +static int swiotlb_do_find_slots(struct io_tlb_mem *mem,
> +		struct io_tlb_area *area, int area_index,
> +		struct device *dev, phys_addr_t orig_addr,
> +		size_t alloc_size, unsigned int alloc_align_mask)

A nit, but why pass the area and area_index as arguments?  The latter
is sufficient to determine the former.  Arguably, don't need the "mem"
argument either since it can be re-read from the dev.  There are a lot
of arguments to this function, so I was trying to see if they are all
really needed.

>  {
> -	struct io_tlb_mem *mem =3D dev->dma_io_tlb_mem;
>  	unsigned long boundary_mask =3D dma_get_seg_boundary(dev);
>  	dma_addr_t tbl_dma_addr =3D
>  		phys_to_dma_unencrypted(dev, mem->start) & boundary_mask;
> @@ -501,8 +598,11 @@ static int swiotlb_find_slots(struct device *dev, ph=
ys_addr_t orig_addr,
>  	unsigned int index, wrap, count =3D 0, i;
>  	unsigned int offset =3D swiotlb_align_offset(dev, orig_addr);
>  	unsigned long flags;
> +	unsigned int slot_base;
> +	unsigned int slot_index;
>=20
>  	BUG_ON(!nslots);
> +	BUG_ON(area_index >=3D mem->nareas);
>=20
>  	/*
>  	 * For mappings with an alignment requirement don't bother looping to
> @@ -514,16 +614,20 @@ static int swiotlb_find_slots(struct device *dev, p=
hys_addr_t orig_addr,
>  		stride =3D max(stride, stride << (PAGE_SHIFT - IO_TLB_SHIFT));
>  	stride =3D max(stride, (alloc_align_mask >> IO_TLB_SHIFT) + 1);
>=20
> -	spin_lock_irqsave(&mem->lock, flags);
> -	if (unlikely(nslots > mem->nslabs - mem->used))
> +	spin_lock_irqsave(&area->lock, flags);
> +	if (unlikely(nslots > mem->area_nslabs - area->used))
>  		goto not_found;
>=20
> -	index =3D wrap =3D wrap_index(mem, ALIGN(mem->index, stride));
> +	slot_base =3D area_index * mem->area_nslabs;
> +	index =3D wrap =3D wrap_area_index(mem, ALIGN(area->index, stride));
> +
>  	do {
> +		slot_index =3D slot_base + index;
> +
>  		if (orig_addr &&
> -		    (slot_addr(tbl_dma_addr, index) & iotlb_align_mask) !=3D
> -			    (orig_addr & iotlb_align_mask)) {
> -			index =3D wrap_index(mem, index + 1);
> +		    (slot_addr(tbl_dma_addr, slot_index) &
> +		     iotlb_align_mask) !=3D (orig_addr & iotlb_align_mask)) {
> +			index =3D wrap_area_index(mem, index + 1);
>  			continue;
>  		}
>=20
> @@ -532,26 +636,26 @@ static int swiotlb_find_slots(struct device *dev, p=
hys_addr_t
> orig_addr,
>  		 * contiguous buffers, we allocate the buffers from that slot
>  		 * and mark the entries as '0' indicating unavailable.
>  		 */
> -		if (!iommu_is_span_boundary(index, nslots,
> +		if (!iommu_is_span_boundary(slot_index, nslots,
>  					    nr_slots(tbl_dma_addr),
>  					    max_slots)) {
> -			if (mem->slots[index].list >=3D nslots)
> +			if (mem->slots[slot_index].list >=3D nslots)
>  				goto found;
>  		}
> -		index =3D wrap_index(mem, index + stride);
> +		index =3D wrap_area_index(mem, index + stride);
>  	} while (index !=3D wrap);
>=20
>  not_found:
> -	spin_unlock_irqrestore(&mem->lock, flags);
> +	spin_unlock_irqrestore(&area->lock, flags);
>  	return -1;
>=20
>  found:
> -	for (i =3D index; i < index + nslots; i++) {
> +	for (i =3D slot_index; i < slot_index + nslots; i++) {
>  		mem->slots[i].list =3D 0;
> -		mem->slots[i].alloc_size =3D
> -			alloc_size - (offset + ((i - index) << IO_TLB_SHIFT));
> +		mem->slots[i].alloc_size =3D alloc_size - (offset +
> +				((i - slot_index) << IO_TLB_SHIFT));
>  	}
> -	for (i =3D index - 1;
> +	for (i =3D slot_index - 1;
>  	     io_tlb_offset(i) !=3D IO_TLB_SEGSIZE - 1 &&
>  	     mem->slots[i].list; i--)
>  		mem->slots[i].list =3D ++count;
> @@ -559,14 +663,43 @@ static int swiotlb_find_slots(struct device *dev, p=
hys_addr_t
> orig_addr,
>  	/*
>  	 * Update the indices to avoid searching in the next round.
>  	 */
> -	if (index + nslots < mem->nslabs)
> -		mem->index =3D index + nslots;
> +	if (index + nslots < mem->area_nslabs)
> +		area->index =3D index + nslots;
>  	else
> -		mem->index =3D 0;
> -	mem->used +=3D nslots;
> +		area->index =3D 0;
> +	area->used +=3D nslots;
> +	spin_unlock_irqrestore(&area->lock, flags);
> +	return slot_index;
> +}
>=20
> -	spin_unlock_irqrestore(&mem->lock, flags);
> -	return index;
> +static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
> +		size_t alloc_size, unsigned int alloc_align_mask)
> +{
> +	struct io_tlb_mem *mem =3D dev->dma_io_tlb_mem;
> +	int start =3D raw_smp_processor_id() & ((1U << __fls(mem->nareas)) - 1)=
;

Is the __fls needed?  mem->nareas must be a power of 2, so it seems like
raw_smp_processor_id() & (mem->nareas - 1) would be sufficient.

> +	int i =3D start, index;
> +
> +	do {
> +		index =3D swiotlb_do_find_slots(mem, mem->areas + i, i,
> +					      dev, orig_addr, alloc_size,
> +					      alloc_align_mask);
> +		if (index >=3D 0)
> +			return index;
> +		if (++i >=3D mem->nareas)
> +			i =3D 0;
> +	} while (i !=3D start);
> +
> +	return -1;
> +}
> +
> +static unsigned long mem_used(struct io_tlb_mem *mem)
> +{
> +	int i;
> +	unsigned long used =3D 0;
> +
> +	for (i =3D 0; i < mem->nareas; i++)
> +		used +=3D mem->areas[i].used;
> +	return used;
>  }
>=20
>  phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_=
addr,
> @@ -598,7 +731,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev=
, phys_addr_t orig_addr,
>  		if (!(attrs & DMA_ATTR_NO_WARN))
>  			dev_warn_ratelimited(dev,
>  	"swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (s=
lots)\n",
> -				 alloc_size, mem->nslabs, mem->used);
> +				 alloc_size, mem->nslabs, mem_used(mem));
>  		return (phys_addr_t)DMA_MAPPING_ERROR;
>  	}
>=20
> @@ -628,6 +761,8 @@ static void swiotlb_release_slots(struct device *dev,=
 phys_addr_t tlb_addr)
>  	unsigned int offset =3D swiotlb_align_offset(dev, tlb_addr);
>  	int index =3D (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
>  	int nslots =3D nr_slots(mem->slots[index].alloc_size + offset);
> +	int aindex =3D index / mem->area_nslabs;
> +	struct io_tlb_area *area =3D &mem->areas[aindex];
>  	int count, i;
>=20
>  	/*
> @@ -636,7 +771,9 @@ static void swiotlb_release_slots(struct device *dev,=
 phys_addr_t tlb_addr)
>  	 * While returning the entries to the free list, we merge the entries
>  	 * with slots below and above the pool being returned.
>  	 */
> -	spin_lock_irqsave(&mem->lock, flags);
> +	BUG_ON(aindex >=3D mem->nareas);
> +
> +	spin_lock_irqsave(&area->lock, flags);
>  	if (index + nslots < ALIGN(index + 1, IO_TLB_SEGSIZE))
>  		count =3D mem->slots[index + nslots].list;
>  	else
> @@ -660,8 +797,8 @@ static void swiotlb_release_slots(struct device *dev,=
 phys_addr_t tlb_addr)
>  	     io_tlb_offset(i) !=3D IO_TLB_SEGSIZE - 1 && mem->slots[i].list;
>  	     i--)
>  		mem->slots[i].list =3D ++count;
> -	mem->used -=3D nslots;
> -	spin_unlock_irqrestore(&mem->lock, flags);
> +	area->used -=3D nslots;
> +	spin_unlock_irqrestore(&area->lock, flags);
>  }
>=20
>  /*
> @@ -759,12 +896,14 @@ EXPORT_SYMBOL_GPL(is_swiotlb_active);
>  static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
>  					 const char *dirname)
>  {
> +	unsigned long used =3D mem_used(mem);
> +
>  	mem->debugfs =3D debugfs_create_dir(dirname, io_tlb_default_mem.debugfs=
);
>  	if (!mem->nslabs)
>  		return;
>=20
>  	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nslabs)=
;
> -	debugfs_create_ulong("io_tlb_used", 0400, mem->debugfs, &mem->used);
> +	debugfs_create_ulong("io_tlb_used", 0400, mem->debugfs, &used);

If I understand debugfs_create_ulong() correctly, it doesn't work to specif=
y a local
variable address as the last argument.  That address is saved and accessed =
after this
function exits.

>  }
>=20
>  static int __init __maybe_unused swiotlb_create_default_debugfs(void)
> @@ -815,6 +954,9 @@ static int rmem_swiotlb_device_init(struct reserved_m=
em *rmem,
>  	struct io_tlb_mem *mem =3D rmem->priv;
>  	unsigned long nslabs =3D rmem->size >> IO_TLB_SHIFT;
>=20
> +	/* Set Per-device io tlb area to one */
> +	unsigned int nareas =3D 1;
> +
>  	/*
>  	 * Since multiple devices can share the same pool, the private data,
>  	 * io_tlb_mem struct, will be initialized by the first device attached
> @@ -831,10 +973,18 @@ static int rmem_swiotlb_device_init(struct reserved=
_mem *rmem,
>  			return -ENOMEM;
>  		}
>=20
> +		mem->areas =3D kcalloc(nareas, sizeof(*mem->areas),
> +				GFP_KERNEL);
> +		if (!mem->areas) {
> +			kfree(mem);
> +			kfree(mem->slots);

These two kfree() calls are in the wrong order.

> +			return -ENOMEM;
> +		}
> +
>  		set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
>  				     rmem->size >> PAGE_SHIFT);
>  		swiotlb_init_io_tlb_mem(mem, rmem->base, nslabs, SWIOTLB_FORCE,
> -				false);
> +					false, nareas);
>  		mem->for_alloc =3D true;
>=20
>  		rmem->priv =3D mem;
> --
> 2.25.1

