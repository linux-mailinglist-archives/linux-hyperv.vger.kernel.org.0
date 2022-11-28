Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798FC639F84
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Nov 2022 03:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiK1CjF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 27 Nov 2022 21:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiK1CjB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 27 Nov 2022 21:39:01 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11022020.outbound.protection.outlook.com [52.101.53.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D1311453;
        Sun, 27 Nov 2022 18:38:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeggeshO0vSoolnQR+IAYegVu53JlEVIhdOn7G6+WZwZNSo/W915pkXd/bYXr0WhOO77kJIrvk7twTAJcp7iN6uapnpuRqO+zWspGZeMiSn6Y0sWm4QaEk8KWl3iu9XKxHwPjnwY50Fe9eT9qzjyxeJtOH4PGv9qv8yfsxpIsdWT33e9NjX769Gt7ftHkTD7opQEuMAcYkTJ4ou1ZzNZ4d+kt+6gbZYbzPmwQBPASC+BvsXTA/FyK5lB0AZAGE6XsBQwlsuMLQElZKcnswM7V227aSdX5KLdc80QA/LG5tB5r2b9EG5GhW1G6MwAwi329o8wsNfXdTM1BwOVfjoPTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmcFQRWUiEAj8zRLtGEjKIFRGmIBBqk2+xeAOtkAugI=;
 b=YoSDAicFiXByAk/J4tDTbQ3Pll/feERjjPszDMA4qpYx/tmFKEMpE/h9zhgnXyRW1cbBe7Yx91CbKfjulST1RechnpxyOf7rBQ9L3k+pJhhIhjyO1n/ajfryfmRO7SnxjQDlI9FiZyhS1+5fVeyHvhftd52zurC6BmMHZTvOS6U6HQDYK+ZoJaavp6uePsZtIQnRv76NRx1S4byvFK2vXD9X2RJg7Tmpc76AKY0CIPvdjgsvljfaLvDDdTTPOhjhn6/UoQiX6pV5GBs7zLLpa4OvkZery0m6pjMjpvgMfTS5lclsT1oA3liLfZPZGKiTGfxnkwL0moN+MtI9/DtH4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmcFQRWUiEAj8zRLtGEjKIFRGmIBBqk2+xeAOtkAugI=;
 b=c2YDfsfVji2Dc0W9Eg/D5er0rJCET/wT9BdHFZqmjx3N95LTwpi3xjCDCb66xmpXLLuEsuKvZypv1ObqzGWb9M1B4STrECoLCE0VaqzXX0MuawPv4j/jqunwmhWrEWZ3hnIqLoGhtjD++9TgFc0iVWLtAfgfCfit3FVnuikuafk=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by BY3PR21MB3032.namprd21.prod.outlook.com (2603:10b6:a03:3b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Mon, 28 Nov
 2022 02:38:53 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%6]) with mapi id 15.20.5880.008; Mon, 28 Nov 2022
 02:38:52 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH] x86/sev: mem_encrypt_free_decrypted_mem(): encrypt the
 pages for AMD SME only
Thread-Topic: [PATCH] x86/sev: mem_encrypt_free_decrypted_mem(): encrypt the
 pages for AMD SME only
Thread-Index: AQHZAsjV3qWeGc+uwEWA8eQOTjd8wK5TnrUw
Date:   Mon, 28 Nov 2022 02:38:52 +0000
Message-ID: <SA1PR21MB13356CD7D2AADCD3F6D8B49EBF139@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221128012852.8561-1-decui@microsoft.com>
In-Reply-To: <20221128012852.8561-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=363a1e4c-ed5f-4cef-a6d5-fc9a59ed3519;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-28T02:35:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|BY3PR21MB3032:EE_
x-ms-office365-filtering-correlation-id: aad5a5fa-0684-4b21-7017-08dad0e9b017
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 65iF50fKscFph13Hc6PB4jOxYthYbUwsC4or4N30xBB8m7icFxHL12anvOnirf8kth6+wnLzjZqfIRMQwYp1PY0JuDpxvjGWRpAiWvF0jcy6dxPPxa56GH8kJS1OZx8FbuQGKv6y4hdGd1jiEi3ekYgkVCTaklrX52VSFO6TX+dQr4EHJl8TTfOw+bQeH6RCgIoc9cEK0SVLF9X8lVthN6pEj+oHVD8T/UgDlDBNcPp+BAsX8rbu6bMAc63f8CdSzfjS1bZyE7gwa9wYbm/dimNt3tyHv4g9OMOpTTSnbJx6xBQ5mxJ2U9q16DYmjFfGnGNN8QrYsNnWR++UeYcQfyncQZaDWBpj+3bVWtGlkcTCLTSNYyf9OJI6FzqP0mmt6freY9QN66oUzZwLqEcCvTt8u8iFdsxjSsh2ATiJsFv6TMxQJ3Ht1t0P8nZ6RxEMgnqn8GU4FE4YR+eEBgHrme2DJpsGUtP3l8uhKSwnjjyswoYx+wmTkjmH8XiK0f8EUZJwpX7Tp3IFum2/i72zKOX6rhoHlRl2mdzrNYWNg2w5GEXCNXZQPZYSWBT2lSt4QuiHjgjUh/cwJX1yMLKexhMj8OVtK5GldwPP9PYvGG63tRCc7xwC1z2A4qATTKEDD77JUsQQZDTTgFV8XmT7bxTp1dArm4N7R/TGGob0EpWqPDGUAv4KnnNydbvHj/WYU/A+pbvfsMgcKrchrxAcF6uJWpZc3PdrXOhEjygcr5whlsefzQnXHsaRy4mOP12BaVLKBewqddhVqGNjoNFRwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199015)(966005)(7696005)(6506007)(83380400001)(8990500004)(86362001)(10290500003)(53546011)(478600001)(71200400001)(66946007)(9686003)(316002)(66556008)(66446008)(8936002)(110136005)(41300700001)(54906003)(76116006)(55016003)(26005)(5660300002)(7416002)(33656002)(38070700005)(38100700002)(2906002)(82960400001)(82950400001)(52536014)(66476007)(186003)(8676002)(64756008)(4326008)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dVtKiqCsFaVvLljQP0ppoXkvCQN5L0b9jBojxXJDLUgWVSsRyu8VUHEoxZHO?=
 =?us-ascii?Q?YRrnApca5fpxICT7Ow3C1WWsRmiEI7OkxVjYsHNcsWsZ4O7CJWnvVtRbme8l?=
 =?us-ascii?Q?wpc0G2eV70LH+wXlbbm1ahMfmrbxfsRpPOkW05iXFVr6dnABFCNm/7F+U/lJ?=
 =?us-ascii?Q?pfWFdc1kjxAemDm4aXblTJIJj+Dw+gAMu4b0h5bmRinlUczpRth4cu7GyQ36?=
 =?us-ascii?Q?TceGqWKgELk3oL5RmR8cXzm61tBNJARQWSCBsB/fJp/T3ErzWjnBh8whk/uN?=
 =?us-ascii?Q?tbOGvfZyM649XcQaxOU5ElwD7g3denfB3gwfJ8TmqQLnqc/bWg61ZgLWBW15?=
 =?us-ascii?Q?4navipsUoKxO/JqFUtDT0NaMOJJ7WNmJBpWqEP4giw0w2hXSMUPHyXubHGCN?=
 =?us-ascii?Q?3XZdSLiGSKzaCVA+KQl0COsW1icAt+3gWerFlfaP8J5yrtzhFm9TSJpC1Ven?=
 =?us-ascii?Q?cilOeWDue3d4aJuT3INOhfYBO6PHKladtS+dubBJ848RSR06RAtwylKrOfSa?=
 =?us-ascii?Q?4Dg4BOVBSQAEK54P4iUyuDO9FFEovC2HiIpVDCZpT2WudvcznsoCR3KaXvXC?=
 =?us-ascii?Q?4+ppmGmnHLOQORmQItlZ/SYvQC4PZ5JtZew/qV0rrwSu23fdA+G3HQvBM0vK?=
 =?us-ascii?Q?05q3NK7a12Pj4jtqGlr7rxTeqGAVKKClHTKnAShe/wOHVYpZeGsmjNWRqFw/?=
 =?us-ascii?Q?oRtSZgirfrMfTLiMZGk+xhxscMGxNhHitLCj6isd6I/IDSB285J/vPspg4Sb?=
 =?us-ascii?Q?NTDzCA8bvRYIYOxn/iNAvex3k1omfQJGrxRo83JxW+ZHgbfMp57GyoNf5cDe?=
 =?us-ascii?Q?XlEUxiKzuBA4qCImD11uLcJYhv7/WNat0f7C8Q5kIqcq90BNR45l4DjyKZfv?=
 =?us-ascii?Q?qxv4Zl0QNdCYJU98bKF70gjoRe7/aVZ8VKGd1yhnLZdE1ue+zZ0g3/p7r+GO?=
 =?us-ascii?Q?Sr86Dg0zxUU6D68GrihhHHXYnxmvYUoc2+GXU1Icp73NUTrvFXTtQGQ35VGJ?=
 =?us-ascii?Q?kF7wa3Bc0d+E5uB4TSttPKL8OszNLgC2XPcE+SDNkz2niNu/vGhjAGqj4tNQ?=
 =?us-ascii?Q?4KjqTDZTSOHQ6YkMWiS7OOuwaEXKhdVNZCJZixMlnJpPpMDeWTri4cbXcrkU?=
 =?us-ascii?Q?bRhAT7r63sDNH01TYf100byr8FIrD2fe7PMhLefGnbJ4HHjsdU9o5qczVaZN?=
 =?us-ascii?Q?986af4pIBc0nAbaHqb1lxgyUWRggdhYU2FENVqv1ozg+ecIgVGjooA1/8ex1?=
 =?us-ascii?Q?xT7vxA/IdxYnBQwyX/8PEOtH7Ro3Cl84qSdVFqb+8OSsSiW6tx6qmYcwWaWQ?=
 =?us-ascii?Q?NuIvHnMGeu1i+63//pXHf72s2pRHoIKtNWzUi5MxoEk9zClEkZGVQY6Jpnxw?=
 =?us-ascii?Q?AC6oV3sd9yA/atjwiWAEcI3RFJ4zvXwPJYN90dpK/qpvw566JgjzyvuvfdyE?=
 =?us-ascii?Q?5LN50IKm/Jzid5fCPxW7+DR3FUPvwsEx2CakwRhci2ngDaCXq1E05Z3zI8qZ?=
 =?us-ascii?Q?sTv9Y2g7Nbcj4tMnQORUYYT1Ln7kJDTVc1Y+ilT9y8c58pnY0USmly7xdq2P?=
 =?us-ascii?Q?8tNEalHzguBbRFOvb7h9+z/CcIaDNmoP9btpccH6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad5a5fa-0684-4b21-7017-08dad0e9b017
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 02:38:52.6474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sundJ3J2ZXhO2mn36/e0EmM/q7oHKXBl2RfYZc2QHI3oRsqGaBzIjXWOWG/f192zdELodohyJcdNSUsCCTSfjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR21MB3032
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Dexuan Cui <decui@microsoft.com>
> Sent: Sunday, November 27, 2022 5:29 PM
> To: dave.hansen@linux.intel.com; luto@kernel.org; peterz@infradead.org;
> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de; x86@kernel.org;
> hpa@zytor.com; brijesh.singh@amd.com
> Cc: linux-kernel@vger.kernel.org; linux-hyperv@vger.kernel.org; Dexuan Cu=
i
> <decui@microsoft.com>
> Subject: [PATCH] x86/sev: mem_encrypt_free_decrypted_mem(): encrypt the
> pages for AMD SME only
>=20
> sme_postprocess_startup() marks the __start_bss_decrypted pages shared
> for AMD SME only, so here set_memory_encrypted() should be called for AMD
> SME only, i.e. don't call the set_memory_encrypted() for TDX, otherwise t=
he
> error "failed to free unused decrypted pages" appears in 'dmesg'.
>=20
> Fixes: b3f0907c71e0 ("x86/mm: Add .bss..decrypted section to hold shared
> variables")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  arch/x86/mm/mem_encrypt_amd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/mm/mem_encrypt_amd.c
> b/arch/x86/mm/mem_encrypt_amd.c
> index 9c4d8dbcb129..fd9b58402a22 100644
> --- a/arch/x86/mm/mem_encrypt_amd.c
> +++ b/arch/x86/mm/mem_encrypt_amd.c
> @@ -516,7 +516,7 @@ void __init mem_encrypt_free_decrypted_mem(void)
>  	 * The unused memory range was mapped decrypted, change the
> encryption
>  	 * attribute from decrypted to encrypted before freeing it.
>  	 */
> -	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
> +	if (sme_me_mask && cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
>  		r =3D set_memory_encrypted(vaddr, npages);
>  		if (r) {
>  			pr_warn("failed to free unused decrypted pages\n");
> --

Please ignore this patch as Michael posted a similar patch earlier:
https://lwn.net/ml/linux-kernel/1668624097-14884-6-git-send-email-mikelley%=
40microsoft.com/
