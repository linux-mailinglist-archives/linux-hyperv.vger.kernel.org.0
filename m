Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750C6605F45
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Oct 2022 13:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiJTLvj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Oct 2022 07:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiJTLvi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Oct 2022 07:51:38 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C151C19D5;
        Thu, 20 Oct 2022 04:51:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZGgRa3kdGSuCZRm+Hv4TjScY2SIvPHeWTGnviJGzfM7wLx+OVUHPdlhHOXQ1DuZrIMk9wSurTH+m5Jk5y9by2wfpSLowaS9ADSG0IlqTrGrZqf9gkwBqJ5IeAWknwaNaEVxArsqbiZAwhwipP/e1hdfbXMhR2+Ha3crfw5f1zP7wiWX23tx9AfSfg64vgM7IKtfOgyBgkLfhwu1btCayvtujR/pZ/tR0Mu/0n+F2u3UaBTu999vcMA8iQ2NBvuMm4eiRmRMvnMrHFl1koz3dMel9Jye6zhZquUMubYH//BaA9iEgntTdMvezAu1V3a3AlNx3e5ze15RxGQhQGudAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkjpM06ND/1tPS8vCFaUA1j7bWQXJk3S6+Ma6y4+cfY=;
 b=l8qbIUvirfxoM99SNeSfKNWvMb3dFtEv1yFv9HfbKP/Kb/MjjJAwfGOgu80xJ0NZF4XOXMrvUv/bi9H+ObYYX/N6ASiTlDCDhsG0DHQsOOGBKZ7FV4TNK12ykqA0gM4G8GLgqh41RN1pddJV/0s/Tq5CtykrPl/iRMJ3BZ+VXO06K5DbCIL2ImHFJiblER6bcwScDIHvSBWvZhFCCLCm7tmefa+1QKmhr5G5/X39vjIBoxZOnEG800ukSD3WDZNg5tX7pOvD6nc9bSGA0Kohtlj34nROReglIFe8eMVJdiIz4A2Wrj6t5uCaa4tdJxWXFmP4CEyiUPHrfKFGvRcZyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkjpM06ND/1tPS8vCFaUA1j7bWQXJk3S6+Ma6y4+cfY=;
 b=dsyeXoJNcHCjbzP4ZNAVYLXgu0pe8A+opYJYBFnk84JO9MhqSCoYaye+ObyrUo5CQTs87GSP0PNtSul5zL+fMn9m80yN9Mxs51/cR8XcXWLhiAc+tZwEOi1ysx62cUnD0AtYywf/MQYRwvuRQuJ9Nz9gX0iMj99ArryPoQtcey8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 11:51:34 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::805b:58b6:1f27:d644]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::805b:58b6:1f27:d644%6]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 11:51:31 +0000
Message-ID: <b26e508b-7599-3953-6803-7db00b3cfbcb@amd.com>
Date:   Thu, 20 Oct 2022 13:48:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/21] drm/amdgpu: Don't set struct drm_driver.lastclose
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, sam@ravnborg.org, javierm@redhat.com,
        mripard@kernel.org, maarten.lankhorst@linux.intel.com
Cc:     linux-hyperv@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-samsung-soc@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, xen-devel@lists.xenproject.org,
        linux-sunxi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        spice-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, freedreno@lists.freedesktop.org
References: <20221020103755.24058-1-tzimmermann@suse.de>
 <20221020103755.24058-2-tzimmermann@suse.de>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221020103755.24058-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR1001CA0013.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:2::26) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 34bb9327-0e2d-47ac-fb3c-08dab2916e16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: djglQBEcOzQigVniLbe7Uf01Ze6y6L18CCWR2e3mm2E9AzSJ1dwV+R9sPDPXx1A0eWzcwN9YUwpJcH5t5lDYt8a2S3OOz4ouFnAvkOiZmwqnMV9iuwXW25FJ9kjsfDbwGJkT7TgyjGnN44KeQQjy4ZrJeyk/f0GIiIHR9a9IjFOhNx/Z1RfFqa0I/bhvNXRgm2zjwB7e01lEEn80TTf1cKy8g8hCCFE2XpfDIpG+0VwA3xQbDrCnNvu5FvJgW8iY6Vi4W5OSKweYsYGNp4n6gr6A0nKoez9CLbTESEbneiGYKRkE7a4biikyvj8Os0QTiSYK8AS5LUYhj7chpPGfZLuIYwy9CuJQTbs84z/GXy+7/1SzfhsrNnpgo0895gXIwmQt0rDnk7/jcw/6z8MsUC6Wohh4Tw1h7nvtCD+VKTbRR4Q2N3uRzI3fNHsn20o0DadkRUci7fmPE519U9990lvL3F7E/UmaWxTYjJffWnyuqRRK1+ble/q7/zQn37U3/ntUtHzCoJPUFWVQCNni+b+cNvUTis5Ko9VhihiorGXCPuberCeKqVHTN6dALg8D3TMOxJjAXyAxnFC9NmEb+9cpJ+n8JXn0MG+hlQYb5G9KtPOE73WJ/iLT3UkJehD07nkhzgdEx/e/DQegQMNTt52NXTPFUJRXTDl4Nswuq2u0jWPyF9pPEoLfSdAz1J2VKUnnvQTxlrYPx8i0GVW6DfSVsJX1ai9iEyELVV/jTK86xzG+FMW1Pqn5bj5xMFNxd8FRB78bF/t4oQZan14UkaO5EKNcXz1LE+k5omCyxfI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199015)(6512007)(26005)(6666004)(478600001)(83380400001)(186003)(7416002)(6506007)(5660300002)(2616005)(66556008)(316002)(41300700001)(4326008)(66946007)(6486002)(8936002)(66476007)(8676002)(31696002)(86362001)(36756003)(38100700002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGR3cjIySk43T2JMVlU0NnRNVWdGcUFnNElKV3FWSlVncC8waUlFRlBPamls?=
 =?utf-8?B?ckxnR1V4Y2JUYWhsZGFNemdrSXBYOUhlNldFZTZ1Q3NDOWtCelpQVkRwQkE5?=
 =?utf-8?B?NDRTc2N3T3VydE1ma2pyaEdrcFZmZW1iVTlsY2ZYMXZuQ0FBYkF6aUFhZ3VI?=
 =?utf-8?B?OE9JbFFXeDhVSTdsblY3cWdUUUh4TmorTFpPRm11eVFwYzgwU2J3UGpTUjdz?=
 =?utf-8?B?TFdVSndhVDQxRVdxbVcrczA4YnpHWHZROHVncnJVckkyZHc4Q0tqM2V4VlBo?=
 =?utf-8?B?Yk5WSFcxQVdEUzhXRm1TUHgyUnhZcnArZG5XQ2gyNFZYSzFlN3lBdmRUUEpk?=
 =?utf-8?B?SkdmR29HNnNHWk9iWW0xUjZaWlltL1hmZE9NaVRKU2NSeUNkSkU3dGozbHFV?=
 =?utf-8?B?alR4d3QrZnROOG5QU1p2dHNvbkozdWUvdjB5QThwZitmTi9lZEVnRm1Ra2hC?=
 =?utf-8?B?anZETzJnUDRwQUtjSWMrQ3lFWjhjcTRzOHlPcVhndUF1OTBrYWt3V0JrYTBo?=
 =?utf-8?B?d0ErU0xnWlpmbWJKcm94VEg2YVlmRnB0OFIvMkgxTEpvd05sbVhKRGkzL3JO?=
 =?utf-8?B?Q1BEUWpsSVdXUnBTVkhYYjVmcllDdGhudjFjYkJ1OHFnTnE0MFprUzFGaFJt?=
 =?utf-8?B?YTRWUUVCQ0NQczRjRjFjblRBTDdFZ3RoaXo1Yy9LS09MTGJIR1NLd0FmUTNS?=
 =?utf-8?B?aFdXTXgyU0dTTVcrcGQ4NVhhUHNqZnNmWUUzbWlPdW00Y3ZyWUF1eE5sc1Nq?=
 =?utf-8?B?ek50Q0pveXpxNmRIRWkwS3dhb3lmZFhJcHk0YnJPMU1DTXRMS05WWXlFdHpz?=
 =?utf-8?B?RlZXRDA5c0x0Skt4SkEwZmUxWFZoZ205WUJsc2NVbXkvZFA0bDNQQmNvRFh6?=
 =?utf-8?B?dmhwNzBFVDlXZ0puQ0I5Mi9Wb1V2QStybzVXSkJPUjErZ0hLbG02L2hnZDVx?=
 =?utf-8?B?Tmt1TzVtbW5mM21Pb0hRSTl4Z2hUdEhBMzRTQTYzY1FNeGV3TWxtZXZzYTJN?=
 =?utf-8?B?cnFEQkdUMWE1bGM2QzVPK3JoQWZLejNnc2pGYjhaZm5YQ2lrelhGei94djNo?=
 =?utf-8?B?SkxCRDIzSUw1S21ZdXAzUW8zK25JTWd0OU1IbXZoZEg5QlFPWFhUZHpraDZn?=
 =?utf-8?B?Q1ZNUG0vNm9jeEVSTTVKUTVQYzlvNDFnMklrK3ljZy9PcDA2cXhCSW14Z3Fl?=
 =?utf-8?B?aE80WGxDb1o4NTBmV28wVXhzRGJRV0hoQk1pUnUzQ2U0VlFTZk9ZMlBaajBu?=
 =?utf-8?B?T0wrV3U4VE16cW50VWE5M2YzdVJYRnFTMVllR0htK0RjTE1qNlR2TDhJa2N4?=
 =?utf-8?B?aExYaGx1RDROOFRWdlAwWEFjYzIvM1VDNkRVWElESjZ2WUV6QVNjVW1nL2Uv?=
 =?utf-8?B?SWhuVDExdzJKbnZPUkh0RHdlMnJGdFp3eUt4eitOckxyZXIwUEhEb0I0alBE?=
 =?utf-8?B?TFQ3OUUwb21tWFVSZ2pFUDVMMkUxSlFEY0hoUkhJcXJIRTM4ZXJMRWRlVm5V?=
 =?utf-8?B?d3FjTExlWm1lWHlpQjNpUW1Mc3p0SkRXK1l0QnFDRTZxZ2xpcXNQNjVvb1Q4?=
 =?utf-8?B?SWtvTDhuU3pFcHZoQVVvUGp6d1RXOXZoT3pEbFBIcDZtYXNWaWNMMWMySStt?=
 =?utf-8?B?NkhmRXU4ZFk4Mm5XWkJKZ2UvWmI4ZTMyVmQ3NTZYbFFzRnVjazllbm1wWFRz?=
 =?utf-8?B?TVRSempBYzlXNThpcVBXQWY3QTYvSVVwMEw5dXRoUGIwd2lJSm9YMStnYTQr?=
 =?utf-8?B?UUZYNnM2YzdlQ095d1ozZUk2ZXZqTXlsTERQZVN1aXp4QURrZEhQYnlCYUZl?=
 =?utf-8?B?cjVNZWZ6N3hjbGF2ZXFxUFBOay8vWndOTXFIZFZVWUZUM3prQWNMM1Z5NFFN?=
 =?utf-8?B?M09uczcvS3R6dVZzVEdzbGpMNWxvTWdMbTRVVUUwZFVUL3lGQU90V0kyRU52?=
 =?utf-8?B?L2U5OUVzclpiYk05OHVFL29YSC9COTgvZzV2cDRFTnczOXFkUEQrRVdINmV4?=
 =?utf-8?B?NUw1T3RjODJlVEE5Q2k2VUNaYXJWSEF6THFMK1VHQzMwTEZicy8vaXZFYTNB?=
 =?utf-8?B?RWRJc3pGMjRzM3BiOURCZVQ2c3NwN0o1OTdxYVplS3pmakdpaUk1TXc1bUZs?=
 =?utf-8?Q?81xaw8csJVBvRA3mTABTFHhlz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bb9327-0e2d-47ac-fb3c-08dab2916e16
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 11:51:31.6004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5OeVYNFFTSt7GCUp4ykoNFJm7pu1DjoecANWmf//HoEVyDQ3WU2UDqJkXgyXYuB7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Am 20.10.22 um 12:37 schrieb Thomas Zimmermann:
> Don't set struct drm_driver.lastclose. It's used to restore the
> fbdev console. But as amdgpu uses generic fbdev emulation, the
> console is being restored by the DRM client helpers already. See
> the call to drm_client_dev_restore() in drm_lastclose().

???

The commit message doesn't match what the patch is doing. You are 
removing output_poll_changed instead of lastclose here.

Did something got mixed up?

Cheers,
Christian.

>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c       | 1 -
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 --
>   2 files changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 23998f727c7f9..fb7186c5ade2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -1224,7 +1224,6 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
>   
>   const struct drm_mode_config_funcs amdgpu_mode_funcs = {
>   	.fb_create = amdgpu_display_user_framebuffer_create,
> -	.output_poll_changed = drm_fb_helper_output_poll_changed,
>   };
>   
>   static const struct drm_prop_enum_list amdgpu_underscan_enum_list[] =
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index f6a9e8fdd87d6..e9a28a5363b9a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -82,7 +82,6 @@
>   #include <drm/drm_atomic_uapi.h>
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_blend.h>
> -#include <drm/drm_fb_helper.h>
>   #include <drm/drm_fourcc.h>
>   #include <drm/drm_edid.h>
>   #include <drm/drm_vblank.h>
> @@ -2810,7 +2809,6 @@ const struct amdgpu_ip_block_version dm_ip_block =
>   static const struct drm_mode_config_funcs amdgpu_dm_mode_funcs = {
>   	.fb_create = amdgpu_display_user_framebuffer_create,
>   	.get_format_info = amd_get_format_info,
> -	.output_poll_changed = drm_fb_helper_output_poll_changed,
>   	.atomic_check = amdgpu_dm_atomic_check,
>   	.atomic_commit = drm_atomic_helper_commit,
>   };

