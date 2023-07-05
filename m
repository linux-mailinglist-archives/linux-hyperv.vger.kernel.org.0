Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0851A748277
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jul 2023 12:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjGEKrk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jul 2023 06:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjGEKri (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jul 2023 06:47:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351F1CE;
        Wed,  5 Jul 2023 03:47:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8999614B5;
        Wed,  5 Jul 2023 10:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA84C433C8;
        Wed,  5 Jul 2023 10:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688554056;
        bh=tXaDAEFFqwz3MdzV/UCaf19abTnplFxYfyIVI9HClWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O+/a/TH9sFtTiOWjJ4Jn/673r1B8raG26yzICtJ85aWfDs1A1XBGJ7uIl3rpSZaJl
         vfc9s/J80ymott0va8GQ6vTMCPy2IuiM+Iizp1XRjrHh+oExEjKT6/Z17IdcBuFF6O
         g6chK1heLOpjzzP7d5ur7PlghtJT69zzMiONE93OphqY2eDnIq0+tUX9CxaLe16rvG
         zyEJOFePaGdiYRqY+oA3GkSv6wWmk98Chn7ldWPQ7G9zsCK9zZZjDMiitOdSwIY4Be
         3F0g5iU3h5q8KvYuWB0ImkANgS8eOqMhMdMLYAh6kv2DoXMiFlPXDunt89QPhqZLFu
         s1DdEZFza7UrQ==
Date:   Wed, 5 Jul 2023 13:47:31 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
        sharmaajay@microsoft.com, cai.huoqing@linux.dev,
        ssengar@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, stable@vger.kernel.org,
        schakrabarti@microsoft.com
Subject: Re: [PATCH net] net: mana: Configure hwc timeout from hardware
Message-ID: <20230705104731.GM6455@unreal>
References: <1688549578-12906-1-git-send-email-schakrabarti@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688549578-12906-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jul 05, 2023 at 02:32:58AM -0700, Souradeep Chakrabarti wrote:
> At present hwc timeout value is a fixed value.
> This patch sets the hwc timeout from the hardware.
> 
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 27 +++++++++++++++++++
>  .../net/ethernet/microsoft/mana/hw_channel.c  | 25 ++++++++++++++++-
>  include/net/mana/gdma.h                       | 20 +++++++++++++-
>  include/net/mana/hw_channel.h                 |  5 ++++
>  4 files changed, 75 insertions(+), 2 deletions(-)

We are in merge window now, it is not net material.

> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 8f3f78b68592..5d30347e0137 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -106,6 +106,30 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
>  	return 0;
>  }
>  
> +static int mana_gd_query_hwc_timeout(struct pci_dev *pdev, u32 *timeout_val)
> +{

Callers are not checking return value, so or make this function void or
check return value.

> +	struct gdma_context *gc = pci_get_drvdata(pdev);
> +	struct gdma_query_hwc_timeout_req req = {};
> +	struct gdma_query_hwc_timeout_resp resp = {};
> +	int err;
> +
> +	mana_gd_init_req_hdr(&req.hdr, GDMA_QUERY_HWC_TIMEOUT,
> +			     sizeof(req), sizeof(resp));
> +	req.timeout_ms = *timeout_val;
> +	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
> +	if (err || resp.hdr.status) {

I see this check almost in all callers to mana_gd_send_request(). It
will be nice if mana_gd_send_request() would check status internally
and return error.

> +		dev_err(gc->dev, "Failed to query timeout: %d, 0x%x\n", err,
> +			resp.hdr.status);
> +		return err ? err : -EPROTO;
> +	}
> +
> +	*timeout_val = resp.timeout_ms;
> +	dev_info(gc->dev, "Successfully changed the timeout value %u\n",
> +		 *timeout_val);
> +
> +	return 0;
> +}
> +
>  static int mana_gd_detect_devices(struct pci_dev *pdev)
>  {
>  	struct gdma_context *gc = pci_get_drvdata(pdev);
> @@ -879,6 +903,7 @@ int mana_gd_verify_vf_version(struct pci_dev *pdev)
>  	struct gdma_context *gc = pci_get_drvdata(pdev);
>  	struct gdma_verify_ver_resp resp = {};
>  	struct gdma_verify_ver_req req = {};
> +	struct hw_channel_context *hwc = gc->hwc.driver_data;
>  	int err;
>  
>  	mana_gd_init_req_hdr(&req.hdr, GDMA_VERIFY_VF_DRIVER_VERSION,
> @@ -907,6 +932,8 @@ int mana_gd_verify_vf_version(struct pci_dev *pdev)
>  			err, resp.hdr.status);
>  		return err ? err : -EPROTO;
>  	}
> +	if (resp.pf_cap_flags1 & GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG)
> +		mana_gd_query_hwc_timeout(pdev, &hwc->hwc_timeout);
>  
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> index 9d1507eba5b9..f5980c26fd09 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -174,7 +174,25 @@ static void mana_hwc_init_event_handler(void *ctx, struct gdma_queue *q_self,
>  		complete(&hwc->hwc_init_eqe_comp);
>  		break;
>  
> +	case GDMA_EQE_HWC_SOC_RECONFIG_DATA:
> +		type_data.as_uint32 = event->details[0];
> +		type = type_data.type;
> +		val = type_data.value;
> +
> +		switch (type) {
> +		case HWC_DATA_CFG_HWC_TIMEOUT:
> +			hwc->hwc_timeout = val;
> +			break;
> +
> +		default:
> +			dev_warn(hwc->dev, "Received unknown reconfig type %u\n", type);
> +			break;
> +		}
> +
> +		break;
> +
>  	default:
> +		dev_warn(hwc->dev, "Received unknown gdma event %u\n", event->type);
>  		/* Ignore unknown events, which should never happen. */
>  		break;
>  	}
> @@ -704,6 +722,7 @@ int mana_hwc_create_channel(struct gdma_context *gc)
>  	gd->pdid = INVALID_PDID;
>  	gd->doorbell = INVALID_DOORBELL;
>  
> +	hwc->hwc_timeout = HW_CHANNEL_WAIT_RESOURCE_TIMEOUT_MS;
>  	/* mana_hwc_init_queues() only creates the required data structures,
>  	 * and doesn't touch the HWC device.
>  	 */
> @@ -770,6 +789,8 @@ void mana_hwc_destroy_channel(struct gdma_context *gc)
>  	hwc->gdma_dev->doorbell = INVALID_DOORBELL;
>  	hwc->gdma_dev->pdid = INVALID_PDID;
>  
> +	hwc->hwc_timeout = 0;
> +
>  	kfree(hwc);
>  	gc->hwc.driver_data = NULL;
>  	gc->hwc.gdma_context = NULL;
> @@ -818,6 +839,7 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
>  		dest_vrq = hwc->pf_dest_vrq_id;
>  		dest_vrcq = hwc->pf_dest_vrcq_id;
>  	}
> +	dev_err(hwc->dev, "HWC: timeout %u ms\n", hwc->hwc_timeout);
>  
>  	err = mana_hwc_post_tx_wqe(txq, tx_wr, dest_vrq, dest_vrcq, false);
>  	if (err) {
> @@ -825,7 +847,8 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
>  		goto out;
>  	}
>  
> -	if (!wait_for_completion_timeout(&ctx->comp_event, 30 * HZ)) {
> +	if (!wait_for_completion_timeout(&ctx->comp_event,
> +					 (hwc->hwc_timeout / 1000) * HZ)) {
>  		dev_err(hwc->dev, "HWC: Request timed out!\n");
>  		err = -ETIMEDOUT;
>  		goto out;
> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> index 96c120160f15..88b6ef7ce1a6 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -33,6 +33,7 @@ enum gdma_request_type {
>  	GDMA_DESTROY_PD			= 30,
>  	GDMA_CREATE_MR			= 31,
>  	GDMA_DESTROY_MR			= 32,
> +	GDMA_QUERY_HWC_TIMEOUT		= 84, /* 0x54 */
>  };
>  
>  #define GDMA_RESOURCE_DOORBELL_PAGE	27
> @@ -57,6 +58,8 @@ enum gdma_eqe_type {
>  	GDMA_EQE_HWC_INIT_EQ_ID_DB	= 129,
>  	GDMA_EQE_HWC_INIT_DATA		= 130,
>  	GDMA_EQE_HWC_INIT_DONE		= 131,
> +	GDMA_EQE_HWC_SOC_RECONFIG	= 132,
> +	GDMA_EQE_HWC_SOC_RECONFIG_DATA	= 133,
>  };
>  
>  enum {
> @@ -531,10 +534,12 @@ enum {
>   * so the driver is able to reliably support features like busy_poll.
>   */
>  #define GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX BIT(2)
> +#define GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG BIT(3)
>  
>  #define GDMA_DRV_CAP_FLAGS1 \
>  	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
> -	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX)
> +	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
> +	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG)
>  
>  #define GDMA_DRV_CAP_FLAGS2 0
>  
> @@ -664,6 +669,19 @@ struct gdma_disable_queue_req {
>  	u32 alloc_res_id_on_creation;
>  }; /* HW DATA */
>  
> +/* GDMA_QUERY_HWC_TIMEOUT */
> +struct gdma_query_hwc_timeout_req {
> +	struct gdma_req_hdr hdr;
> +	u32 timeout_ms;
> +	u32 reserved;
> +};
> +
> +struct gdma_query_hwc_timeout_resp {
> +	struct gdma_resp_hdr hdr;
> +	u32 timeout_ms;
> +	u32 reserved;
> +};
> +
>  enum atb_page_size {
>  	ATB_PAGE_SIZE_4K,
>  	ATB_PAGE_SIZE_8K,
> diff --git a/include/net/mana/hw_channel.h b/include/net/mana/hw_channel.h
> index 6a757a6e2732..3d3b5c881bc1 100644
> --- a/include/net/mana/hw_channel.h
> +++ b/include/net/mana/hw_channel.h
> @@ -23,6 +23,10 @@
>  #define HWC_INIT_DATA_PF_DEST_RQ_ID	10
>  #define HWC_INIT_DATA_PF_DEST_CQ_ID	11
>  
> +#define HWC_DATA_CFG_HWC_TIMEOUT 1
> +
> +#define HW_CHANNEL_WAIT_RESOURCE_TIMEOUT_MS 30000
> +
>  /* Structures labeled with "HW DATA" are exchanged with the hardware. All of
>   * them are naturally aligned and hence don't need __packed.
>   */
> @@ -182,6 +186,7 @@ struct hw_channel_context {
>  
>  	u32 pf_dest_vrq_id;
>  	u32 pf_dest_vrcq_id;
> +	u32 hwc_timeout;
>  
>  	struct hwc_caller_ctx *caller_ctx;
>  };
> -- 
> 2.34.1
> 
