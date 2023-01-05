Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3AE65F075
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Jan 2023 16:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbjAEPuA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Jan 2023 10:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbjAEPtt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Jan 2023 10:49:49 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFB3E5E0AF;
        Thu,  5 Jan 2023 07:49:44 -0800 (PST)
Received: from [192.168.1.139] (unknown [171.76.81.144])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5C11C20B92A6;
        Thu,  5 Jan 2023 07:49:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5C11C20B92A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1672933784;
        bh=0v/gHnV4/FCZJcZCbhikJ55+5Y2tDevbiGhyDSXrEfk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DtiA9z87X+rXYdHGnyJgRnyyh2fOV4IvA7ypFr50x3z1C6FTZ9f/k0+bVTQFi99op
         g9ugF9WBPGojgK95vY8/5aPW5apbaE+Brv7Oh44je5JriAHKMbg6XnVsYPCftpXy30
         IuRRpyp4LyHRS0AQzuK/IPC3gVkI+FBcDbycgms8=
Message-ID: <bdf358a4-03e7-c07c-bb76-dfd85bd8dcd8@linux.microsoft.com>
Date:   Thu, 5 Jan 2023 21:19:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3] Drivers: hv: Make remove callback of hyperv driver
 void returned
To:     Dawei Li <set_pte_at@outlook.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com
Cc:     mikelley@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <TYCP286MB2323A93C55526E4DF239D3ACCAFA9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
Content-Language: en-US
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
In-Reply-To: <TYCP286MB2323A93C55526E4DF239D3ACCAFA9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-22.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 05-01-2023 20:21, Dawei Li wrote:
> Since commit fc7a6209d571 ("bus: Make remove callback return
> void") forces bus_type::remove be void-returned, it doesn't
> make much sense for any bus based driver implementing remove
> callbalk to return non-void to its caller.
> 
> As such, change the remove function for Hyper-V VMBus based
> drivers to return void.
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
> v2 -> v3
> - Update commit message and restore blank line as it is,
>   based on the comments from Michael Kelley.
> 
> v1 -> v2
> - Fixed null dereference issue and deprecated comments, based
>   on comments by Liu Wei.
> - Fixed building issue.
> - Rebased on latest hyperv-next.
> 
> v1
> - https://lore.kernel.org/all/TYCP286MB232373567792ED1AC5E0849FCA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM/
> ---
>  drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 4 +---
>  drivers/hid/hid-hyperv.c                | 4 +---
>  drivers/hv/hv_balloon.c                 | 4 +---
>  drivers/hv/hv_util.c                    | 4 +---
>  drivers/input/serio/hyperv-keyboard.c   | 4 +---
>  drivers/net/hyperv/netvsc_drv.c         | 5 ++---
>  drivers/pci/controller/pci-hyperv.c     | 8 ++------
>  drivers/scsi/storvsc_drv.c              | 4 +---
>  drivers/uio/uio_hv_generic.c            | 5 ++---
>  drivers/video/fbdev/hyperv_fb.c         | 5 +----
>  include/linux/hyperv.h                  | 2 +-
>  net/vmw_vsock/hyperv_transport.c        | 4 +---
>  12 files changed, 15 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> index ca127ff797f7..d117fff26d99 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> @@ -165,7 +165,7 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
>  	return ret;
>  }
>  
> -static int hyperv_vmbus_remove(struct hv_device *hdev)
> +static void hyperv_vmbus_remove(struct hv_device *hdev)
>  {
>  	struct drm_device *dev = hv_get_drvdata(hdev);
>  	struct hyperv_drm_device *hv = to_hv(dev);
> @@ -176,8 +176,6 @@ static int hyperv_vmbus_remove(struct hv_device *hdev)
>  	hv_set_drvdata(hdev, NULL);
>  
>  	vmbus_free_mmio(hv->mem->start, hv->fb_size);
> -
> -	return 0;
>  }
>  
>  static int hyperv_vmbus_suspend(struct hv_device *hdev)
> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> index ab57b49a44ed..ef16c2a54362 100644
> --- a/drivers/hid/hid-hyperv.c
> +++ b/drivers/hid/hid-hyperv.c
> @@ -535,7 +535,7 @@ static int mousevsc_probe(struct hv_device *device,
>  }
>  
>  
> -static int mousevsc_remove(struct hv_device *dev)
> +static void mousevsc_remove(struct hv_device *dev)
>  {
>  	struct mousevsc_dev *input_dev = hv_get_drvdata(dev);
>  
> @@ -544,8 +544,6 @@ static int mousevsc_remove(struct hv_device *dev)
>  	hid_hw_stop(input_dev->hid_device);
>  	hid_destroy_device(input_dev->hid_device);
>  	mousevsc_free_device(input_dev);
> -
> -	return 0;
>  }
>  
>  static int mousevsc_suspend(struct hv_device *dev)
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index cbe43e2567a7..0d4b8fc47ac6 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -2042,7 +2042,7 @@ static int balloon_probe(struct hv_device *dev,
>  	return ret;
>  }
>  
> -static int balloon_remove(struct hv_device *dev)
> +static void balloon_remove(struct hv_device *dev)
>  {
>  	struct hv_dynmem_device *dm = hv_get_drvdata(dev);
>  	struct hv_hotadd_state *has, *tmp;
> @@ -2083,8 +2083,6 @@ static int balloon_remove(struct hv_device *dev)
>  		kfree(has);
>  	}
>  	spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> -
> -	return 0;
>  }
>  
>  static int balloon_suspend(struct hv_device *hv_dev)
> diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
> index 835e6039c186..24995ac41c86 100644
> --- a/drivers/hv/hv_util.c
> +++ b/drivers/hv/hv_util.c
> @@ -602,7 +602,7 @@ static int util_probe(struct hv_device *dev,
>  	return ret;
>  }
>  
> -static int util_remove(struct hv_device *dev)
> +static void util_remove(struct hv_device *dev)
>  {
>  	struct hv_util_service *srv = hv_get_drvdata(dev);
>  
> @@ -610,8 +610,6 @@ static int util_remove(struct hv_device *dev)
>  		srv->util_deinit();
>  	vmbus_close(dev->channel);
>  	kfree(srv->recv_buffer);
> -
> -	return 0;
>  }
>  
>  /*
> diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
> index d62aefb2e245..31def6ce5157 100644
> --- a/drivers/input/serio/hyperv-keyboard.c
> +++ b/drivers/input/serio/hyperv-keyboard.c
> @@ -369,7 +369,7 @@ static int hv_kbd_probe(struct hv_device *hv_dev,
>  	return error;
>  }
>  
> -static int hv_kbd_remove(struct hv_device *hv_dev)
> +static void hv_kbd_remove(struct hv_device *hv_dev)
>  {
>  	struct hv_kbd_dev *kbd_dev = hv_get_drvdata(hv_dev);
>  
> @@ -378,8 +378,6 @@ static int hv_kbd_remove(struct hv_device *hv_dev)
>  	kfree(kbd_dev);
>  
>  	hv_set_drvdata(hv_dev, NULL);
> -
> -	return 0;
>  }
>  
>  static int hv_kbd_suspend(struct hv_device *hv_dev)
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index 89eb4f179a3c..025f805e1ed9 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -2594,7 +2594,7 @@ static int netvsc_probe(struct hv_device *dev,
>  	return ret;
>  }
>  
> -static int netvsc_remove(struct hv_device *dev)
> +static void netvsc_remove(struct hv_device *dev)
>  {
>  	struct net_device_context *ndev_ctx;
>  	struct net_device *vf_netdev, *net;
> @@ -2603,7 +2603,7 @@ static int netvsc_remove(struct hv_device *dev)
>  	net = hv_get_drvdata(dev);
>  	if (net == NULL) {
>  		dev_err(&dev->device, "No net device to remove\n");
> -		return 0;
> +		return;
>  	}
>  
>  	ndev_ctx = netdev_priv(net);
> @@ -2637,7 +2637,6 @@ static int netvsc_remove(struct hv_device *dev)
>  
>  	free_percpu(ndev_ctx->vf_stats);
>  	free_netdev(net);
> -	return 0;
>  }
>  
>  static int netvsc_suspend(struct hv_device *dev)
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 583d3aad6908..e46d9a14053f 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3813,13 +3813,10 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
>  /**
>   * hv_pci_remove() - Remove routine for this VMBus channel
>   * @hdev:	VMBus's tracking struct for this root PCI bus
> - *
> - * Return: 0 on success, -errno on failure
>   */
> -static int hv_pci_remove(struct hv_device *hdev)
> +static void hv_pci_remove(struct hv_device *hdev)
>  {
>  	struct hv_pcibus_device *hbus;
> -	int ret;
>  
>  	hbus = hv_get_drvdata(hdev);
>  	if (hbus->state == hv_pcibus_installed) {
> @@ -3842,7 +3839,7 @@ static int hv_pci_remove(struct hv_device *hdev)
>  		pci_unlock_rescan_remove();
>  	}
>  
> -	ret = hv_pci_bus_exit(hdev, false);
> +	hv_pci_bus_exit(hdev, false);
>  
>  	vmbus_close(hdev->channel);
>  
> @@ -3855,7 +3852,6 @@ static int hv_pci_remove(struct hv_device *hdev)
>  	hv_put_dom_num(hbus->bridge->domain_nr);
>  
>  	kfree(hbus);
> -	return ret;
>  }
>  
>  static int hv_pci_suspend(struct hv_device *hdev)
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 3c5b7e4227b2..02f9d1a6f4ac 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -2092,7 +2092,7 @@ static int storvsc_change_queue_depth(struct scsi_device *sdev, int queue_depth)
>  	return scsi_change_queue_depth(sdev, queue_depth);
>  }
>  
> -static int storvsc_remove(struct hv_device *dev)
> +static void storvsc_remove(struct hv_device *dev)
>  {
>  	struct storvsc_device *stor_device = hv_get_drvdata(dev);
>  	struct Scsi_Host *host = stor_device->host;
> @@ -2108,8 +2108,6 @@ static int storvsc_remove(struct hv_device *dev)
>  	scsi_remove_host(host);
>  	storvsc_dev_remove(dev);
>  	scsi_host_put(host);
> -
> -	return 0;
>  }
>  
>  static int storvsc_suspend(struct hv_device *hv_dev)
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index c08a6cfd119f..20d9762331bd 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -355,20 +355,19 @@ hv_uio_probe(struct hv_device *dev,
>  	return ret;
>  }
>  
> -static int
> +static void
>  hv_uio_remove(struct hv_device *dev)
>  {
>  	struct hv_uio_private_data *pdata = hv_get_drvdata(dev);
>  
>  	if (!pdata)
> -		return 0;
> +		return;
>  
>  	sysfs_remove_bin_file(&dev->channel->kobj, &ring_buffer_bin_attr);
>  	uio_unregister_device(&pdata->info);
>  	hv_uio_cleanup(dev, pdata);
>  
>  	vmbus_free_ring(dev->channel);
> -	return 0;
>  }
>  
>  static struct hv_driver hv_uio_drv = {
> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
> index 3ce746a46179..cfa6a7c1eeb3 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -1240,8 +1240,7 @@ static int hvfb_probe(struct hv_device *hdev,
>  	return ret;
>  }
>  
> -
> -static int hvfb_remove(struct hv_device *hdev)
> +static void hvfb_remove(struct hv_device *hdev)
>  {
>  	struct fb_info *info = hv_get_drvdata(hdev);
>  	struct hvfb_par *par = info->par;
> @@ -1262,8 +1261,6 @@ static int hvfb_remove(struct hv_device *hdev)
>  
>  	hvfb_putmem(hdev, info);
>  	framebuffer_release(info);
> -
> -	return 0;
>  }
>  
>  static int hvfb_suspend(struct hv_device *hdev)
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 85f7c5a63aa6..cd5cb9f6fae0 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1273,7 +1273,7 @@ struct hv_driver {
>  	} dynids;
>  
>  	int (*probe)(struct hv_device *, const struct hv_vmbus_device_id *);
> -	int (*remove)(struct hv_device *);
> +	void (*remove)(struct hv_device *dev);

nitpick for consistency from previous version

void (*remove)(struct hv_device *);


>  	void (*shutdown)(struct hv_device *);
>  
>  	int (*suspend)(struct hv_device *);
> diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
> index 59c3e2697069..7cb1a9d2cdb4 100644
> --- a/net/vmw_vsock/hyperv_transport.c
> +++ b/net/vmw_vsock/hyperv_transport.c
> @@ -879,13 +879,11 @@ static int hvs_probe(struct hv_device *hdev,
>  	return 0;
>  }
>  
> -static int hvs_remove(struct hv_device *hdev)
> +static void hvs_remove(struct hv_device *hdev)
>  {
>  	struct vmbus_channel *chan = hdev->channel;
>  
>  	vmbus_close(chan);
> -
> -	return 0;
>  }
>  
>  /* hv_sock connections can not persist across hibernation, and all the hv_sock

