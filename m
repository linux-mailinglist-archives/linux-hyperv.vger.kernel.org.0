Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7A465F0E8
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Jan 2023 17:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjAEQNp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Jan 2023 11:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjAEQNo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Jan 2023 11:13:44 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2088.outbound.protection.outlook.com [40.92.98.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F29BBE27;
        Thu,  5 Jan 2023 08:13:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMYSGHIRGfQJh9z8PMhZYCgTLGuxM4hwtFcO96QOFV5rM7IOds4oDPM+9cMOrHCvAzXNGlBSgvScoFf7XP1qruOVdwguIN/Nmq3mpyTqFsHCj1MioX9sHmUNEYNjRYuyUMvoEq5a9R4sM4rMIDTKMB3xfCTUOLUs7t7CGORCE1axXpUCDiGiuMrbT9JoWgU0hFF+ZGxSHvW027j8Sq5REt4dg3Gog52zDGW8buccFBYHILE6S7y+e2Y+DNTarSAhTsdXxMaTNFoy6+hO7soPjG/Qu6n5uKxPBErzCkRhU4lxWGpXPjjzgQpEn8CNUu1bVsrY6APB5qPgN/l287Z/jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gED4oZcbD2o648xuYhJY7+16xKXQekgjM7xYorAojsY=;
 b=efArNaKDrJXUGJWI3G9Bmh9AtY1EDhbNFb9Hq2cwAZa8+YAnX3I07KwUniNhOj+/Cmj1+fKxw5UVhCNbK/EYsKXZXO/KBQjAw8GQA61qDHv5b1bfpRhpK0r9IzlLzQQMDI2P9laHMKCyddFDBC9NV4sQV1urYra0UnHtUGATx0vh3cGa2t+nhQMdq9XGEJbijGN+VhrLL0s2CPW+90fNsFVWjQPGDL9NUyu9Y1MXaLWW+D/QU1+ao2NAqON54PxdTMBagYFNJQyaCKrNCi8AXPRw7EYTLH7EASXyjj2EBT7hr3DZfS9YXVxdd4f6n3235CZkIRGZ40c5y+Eu8Ao0vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gED4oZcbD2o648xuYhJY7+16xKXQekgjM7xYorAojsY=;
 b=WKMhb3SzuSKQgUp89bh48GoMQlwPoNACLs/TFtVGsljkoMYj3xHeLPjbBQh/kItNzCWKTtp/E2sKZC269E03ZMYLXkJRWYXOCdWTgIctIQYpDs0BPbZOU0SYCCNloZirUaoZCg/SPAE4lqP6o2EZ8YX9If0D4QtS6GrWNQABS0i5pOR9tOihEZ5Kip0cc8srLpW7XtCdWbuLmSBl5s62U/i0SHjcaKNCArn6rdtcXG3os7ued1KP4+Be6f/HaDlxurqUJjW0r6d4UUtaE4Y35sL2qVbn2UKysSqUaH++Iok/XdwT8Xk87Ub0pfjkqjcujHH05+GFGoGiR14to39EUw==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by OS3P286MB2709.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1fc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 16:13:38 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 16:13:38 +0000
Date:   Fri, 6 Jan 2023 00:13:36 +0800
From:   Dawei Li <set_pte_at@outlook.com>
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, mikelley@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Drivers: hv: Make remove callback of hyperv driver
 void returned
Message-ID: <TYCP286MB2323EE2BBD635263685C2C1ACAFA9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB2323A93C55526E4DF239D3ACCAFA9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
 <bdf358a4-03e7-c07c-bb76-dfd85bd8dcd8@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdf358a4-03e7-c07c-bb76-dfd85bd8dcd8@linux.microsoft.com>
X-TMN:  [lmGKWTbhQxs7Q2a4UiB+qGfo6YsbBe8m]
X-ClientProxiedBy: TYCP286CA0086.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::12) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20230105161336.GA1303389@wendao-VirtualBox>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|OS3P286MB2709:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b09725-0cd1-41e6-db24-08daef37cde7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OZ8zXEOlzzAr9WH3wiVrgmbn+LSkJJC3JKCWlq1yDa636j8ck1C28zD7bFXBRI5QiuZKVqtTmNnsJeztLR7oC5iuPCYZhfGAgCntEv/8UYW/TeQCevfX2purzNSkZQGdA8ApIW6r/IHgmZ7uaOrmBBOWrEWWqB+MBVWDYuF5WjA96tWHOT/o8x0GrdW1tXEv5aJ/r+8QZT/rtjDnE1bP4StUVIoMZNj4XVBgMDSeY3cTqgFl6HK9FydHlXwDgODsTgc7QXUZPzUtszu9zIGmNC1/th01qCI8okuhdsUeoZVUOe4E4RZAkNG1YaPVQkhqd0nHBsS42qXxm5IcOj7kUnc+2cN5r7hp/k9oSjM5/GScRHgrlV6OzFmlxmGtokDM/4qhOg4Gi6zUMbV6Ux/sCU9GuJvEyEygT/uT8bcOS5sqgU9a4liNtbBXvjzH1zF91JKdYfqhRRerjMOSc/LOjy6G0lC7emPIdv+EdsLQ2ZXD1UpfXuDSi3Dg3UJvWFF9XqazP9Z5snv0crgseLMQwgq3hKU8N0t60MRlhoOe+R1E1HPjLY/NCT/40vBIogyaj/KcnDOqvO5DbG+6lXsaqEoz59m5JkKcE7ndGPT2XOUq317vBghAuP2/hn7EeE3DXIRvHkYD8uxqlPSYf5n6kw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wbFgDdslVENPhdTYdK2d5VWnRLMlG30ef1M914YtJROebu4xez50sKx/cz+S?=
 =?us-ascii?Q?3krfro0iXxXjS6KQKRuNkRDPbW/VPJFb1iW+a8UyKzKJ7Lpp9OmEU/wSDAmY?=
 =?us-ascii?Q?zJOfQsMMAn9MlwQw0lCCs/1MgXjTFYIVnzMj2XJSwIAqXxe4Wm2qQIB+O0pO?=
 =?us-ascii?Q?y9X4BjCXUYuKKy1x7eog9ARrC0pXrRTAy5jNtHjbm1j633JXYckXT2JuIpS5?=
 =?us-ascii?Q?S7B9JOnfxHSycRB9vgDJ5yidJfXSjUzizCxnSB0ScXgPz7zw1an6XINLLAgk?=
 =?us-ascii?Q?AE95kPGiNh69jjxT5PeoU+CB1UPcxkdJ60sAgeBs3XbvQNFEU+hcmZDZq30J?=
 =?us-ascii?Q?M2W946POEtF5WYputHLAFPaXd7BqlmmYrwhVn9ngn1TSA69eXk8kPQZornYJ?=
 =?us-ascii?Q?9hzQHzkebQ3HsoMMAaglQByrCpUtpO9CrbXbU+bWmLex873yvp2HzBFJz7ay?=
 =?us-ascii?Q?5zYDJU5PMn+mg/dTCJGq1oQnpvxeFYmyOXb1D3Q04wV92Qmo6NmrUHNmJSPV?=
 =?us-ascii?Q?p4ogKHvFhD4NAhYFLDIP7uvEQLA2KIZpN0zC28ricMGR4j7LmGobSqNpxZEy?=
 =?us-ascii?Q?Vg1Dc4RtmoDVYMpQ+brxW/pkBrLds6IrnjmX5erJ11qgMb8ClTPPthGCLKZq?=
 =?us-ascii?Q?B/DjHduWcd8SHE9QzKTWBk4gpeN1zwZcUQRvMzbdXjiUtWBDgXhot9jJoto4?=
 =?us-ascii?Q?XZZQ4MZDIiavvTM2ZkDcDxcWtoVVj9r4agVixCQq59EPEODr9yvELjAO55kh?=
 =?us-ascii?Q?Zpbx9Nffx8pviGqhC8e6b2w03M8QRgaQ/krUEl6VjNg+Jx4S0/upOxVdbpqK?=
 =?us-ascii?Q?NGscjFsrXi+C03KPjyFRzMHQjZkYpB1V3jrq6q4qWWmD7u5tEKtRCmfob/S8?=
 =?us-ascii?Q?3hLKp2DUP6Ytr3UyyrFlk+jD3DLR+ViLgjUKzMm7bVupLGADax05d61OoaPu?=
 =?us-ascii?Q?hXATwd2St/qFZRMAsRCf4PNBOrSzFhuBakksj7ojmeKu7+hxItZw917m3mct?=
 =?us-ascii?Q?IoozAWWfA3ONi8oBfaZfb+T2IptjhOCS5c6IslDcH+RQ8BMbPiD8/kOJKSPB?=
 =?us-ascii?Q?/X0lTSohE2BOPDgtmHuO6KhcjriDa4ABcKnMfBu2p3zpZ+G0ffG9k7mG9E42?=
 =?us-ascii?Q?LBX0Ci2wKcxnNHPLU/fZtF2kCDcscIjb+IBAFDwnTLDhdPMt96Qe84C8RRxi?=
 =?us-ascii?Q?yNxbdeaGNOI0YOAacNC3apkB9OcCEk+0z1AlJ0v9GaSFNb+Vl4eGJLyU1Qdh?=
 =?us-ascii?Q?6TBld97wgG2sxcKGfYsFpkz9p+GMIKfpr5HMKIVLcA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b09725-0cd1-41e6-db24-08daef37cde7
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 16:13:38.6703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2709
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jan 05, 2023 at 09:19:31PM +0530, Praveen Kumar wrote:

Hi Praveen,

Thanks for reviewing.

> On 05-01-2023 20:21, Dawei Li wrote:
> > Since commit fc7a6209d571 ("bus: Make remove callback return
> > void") forces bus_type::remove be void-returned, it doesn't
> > make much sense for any bus based driver implementing remove
> > callbalk to return non-void to its caller.
> > 
> > As such, change the remove function for Hyper-V VMBus based
> > drivers to return void.
> > 
> > Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> > ---
> > v2 -> v3
> > - Update commit message and restore blank line as it is,
> >   based on the comments from Michael Kelley.
> > 
> > v1 -> v2
> > - Fixed null dereference issue and deprecated comments, based
> >   on comments by Liu Wei.
> > - Fixed building issue.
> > - Rebased on latest hyperv-next.
> > 
> > v1
> > - https://lore.kernel.org/all/TYCP286MB232373567792ED1AC5E0849FCA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM/
> > ---
> >  drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 4 +---
> >  drivers/hid/hid-hyperv.c                | 4 +---
> >  drivers/hv/hv_balloon.c                 | 4 +---
> >  drivers/hv/hv_util.c                    | 4 +---
> >  drivers/input/serio/hyperv-keyboard.c   | 4 +---
> >  drivers/net/hyperv/netvsc_drv.c         | 5 ++---
> >  drivers/pci/controller/pci-hyperv.c     | 8 ++------
> >  drivers/scsi/storvsc_drv.c              | 4 +---
> >  drivers/uio/uio_hv_generic.c            | 5 ++---
> >  drivers/video/fbdev/hyperv_fb.c         | 5 +----
> >  include/linux/hyperv.h                  | 2 +-
> >  net/vmw_vsock/hyperv_transport.c        | 4 +---
> >  12 files changed, 15 insertions(+), 38 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> > index ca127ff797f7..d117fff26d99 100644
> > --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> > +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> > @@ -165,7 +165,7 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
> >  	return ret;
> >  }
> >  
> > -static int hyperv_vmbus_remove(struct hv_device *hdev)
> > +static void hyperv_vmbus_remove(struct hv_device *hdev)
> >  {
> >  	struct drm_device *dev = hv_get_drvdata(hdev);
> >  	struct hyperv_drm_device *hv = to_hv(dev);
> > @@ -176,8 +176,6 @@ static int hyperv_vmbus_remove(struct hv_device *hdev)
> >  	hv_set_drvdata(hdev, NULL);
> >  
> >  	vmbus_free_mmio(hv->mem->start, hv->fb_size);
> > -
> > -	return 0;
> >  }
> >  
> >  static int hyperv_vmbus_suspend(struct hv_device *hdev)
> > diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> > index ab57b49a44ed..ef16c2a54362 100644
> > --- a/drivers/hid/hid-hyperv.c
> > +++ b/drivers/hid/hid-hyperv.c
> > @@ -535,7 +535,7 @@ static int mousevsc_probe(struct hv_device *device,
> >  }
> >  
> >  
> > -static int mousevsc_remove(struct hv_device *dev)
> > +static void mousevsc_remove(struct hv_device *dev)
> >  {
> >  	struct mousevsc_dev *input_dev = hv_get_drvdata(dev);
> >  
> > @@ -544,8 +544,6 @@ static int mousevsc_remove(struct hv_device *dev)
> >  	hid_hw_stop(input_dev->hid_device);
> >  	hid_destroy_device(input_dev->hid_device);
> >  	mousevsc_free_device(input_dev);
> > -
> > -	return 0;
> >  }
> >  
> >  static int mousevsc_suspend(struct hv_device *dev)
> > diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> > index cbe43e2567a7..0d4b8fc47ac6 100644
> > --- a/drivers/hv/hv_balloon.c
> > +++ b/drivers/hv/hv_balloon.c
> > @@ -2042,7 +2042,7 @@ static int balloon_probe(struct hv_device *dev,
> >  	return ret;
> >  }
> >  
> > -static int balloon_remove(struct hv_device *dev)
> > +static void balloon_remove(struct hv_device *dev)
> >  {
> >  	struct hv_dynmem_device *dm = hv_get_drvdata(dev);
> >  	struct hv_hotadd_state *has, *tmp;
> > @@ -2083,8 +2083,6 @@ static int balloon_remove(struct hv_device *dev)
> >  		kfree(has);
> >  	}
> >  	spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> > -
> > -	return 0;
> >  }
> >  
> >  static int balloon_suspend(struct hv_device *hv_dev)
> > diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
> > index 835e6039c186..24995ac41c86 100644
> > --- a/drivers/hv/hv_util.c
> > +++ b/drivers/hv/hv_util.c
> > @@ -602,7 +602,7 @@ static int util_probe(struct hv_device *dev,
> >  	return ret;
> >  }
> >  
> > -static int util_remove(struct hv_device *dev)
> > +static void util_remove(struct hv_device *dev)
> >  {
> >  	struct hv_util_service *srv = hv_get_drvdata(dev);
> >  
> > @@ -610,8 +610,6 @@ static int util_remove(struct hv_device *dev)
> >  		srv->util_deinit();
> >  	vmbus_close(dev->channel);
> >  	kfree(srv->recv_buffer);
> > -
> > -	return 0;
> >  }
> >  
> >  /*
> > diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
> > index d62aefb2e245..31def6ce5157 100644
> > --- a/drivers/input/serio/hyperv-keyboard.c
> > +++ b/drivers/input/serio/hyperv-keyboard.c
> > @@ -369,7 +369,7 @@ static int hv_kbd_probe(struct hv_device *hv_dev,
> >  	return error;
> >  }
> >  
> > -static int hv_kbd_remove(struct hv_device *hv_dev)
> > +static void hv_kbd_remove(struct hv_device *hv_dev)
> >  {
> >  	struct hv_kbd_dev *kbd_dev = hv_get_drvdata(hv_dev);
> >  
> > @@ -378,8 +378,6 @@ static int hv_kbd_remove(struct hv_device *hv_dev)
> >  	kfree(kbd_dev);
> >  
> >  	hv_set_drvdata(hv_dev, NULL);
> > -
> > -	return 0;
> >  }
> >  
> >  static int hv_kbd_suspend(struct hv_device *hv_dev)
> > diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> > index 89eb4f179a3c..025f805e1ed9 100644
> > --- a/drivers/net/hyperv/netvsc_drv.c
> > +++ b/drivers/net/hyperv/netvsc_drv.c
> > @@ -2594,7 +2594,7 @@ static int netvsc_probe(struct hv_device *dev,
> >  	return ret;
> >  }
> >  
> > -static int netvsc_remove(struct hv_device *dev)
> > +static void netvsc_remove(struct hv_device *dev)
> >  {
> >  	struct net_device_context *ndev_ctx;
> >  	struct net_device *vf_netdev, *net;
> > @@ -2603,7 +2603,7 @@ static int netvsc_remove(struct hv_device *dev)
> >  	net = hv_get_drvdata(dev);
> >  	if (net == NULL) {
> >  		dev_err(&dev->device, "No net device to remove\n");
> > -		return 0;
> > +		return;
> >  	}
> >  
> >  	ndev_ctx = netdev_priv(net);
> > @@ -2637,7 +2637,6 @@ static int netvsc_remove(struct hv_device *dev)
> >  
> >  	free_percpu(ndev_ctx->vf_stats);
> >  	free_netdev(net);
> > -	return 0;
> >  }
> >  
> >  static int netvsc_suspend(struct hv_device *dev)
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index 583d3aad6908..e46d9a14053f 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -3813,13 +3813,10 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
> >  /**
> >   * hv_pci_remove() - Remove routine for this VMBus channel
> >   * @hdev:	VMBus's tracking struct for this root PCI bus
> > - *
> > - * Return: 0 on success, -errno on failure
> >   */
> > -static int hv_pci_remove(struct hv_device *hdev)
> > +static void hv_pci_remove(struct hv_device *hdev)
> >  {
> >  	struct hv_pcibus_device *hbus;
> > -	int ret;
> >  
> >  	hbus = hv_get_drvdata(hdev);
> >  	if (hbus->state == hv_pcibus_installed) {
> > @@ -3842,7 +3839,7 @@ static int hv_pci_remove(struct hv_device *hdev)
> >  		pci_unlock_rescan_remove();
> >  	}
> >  
> > -	ret = hv_pci_bus_exit(hdev, false);
> > +	hv_pci_bus_exit(hdev, false);
> >  
> >  	vmbus_close(hdev->channel);
> >  
> > @@ -3855,7 +3852,6 @@ static int hv_pci_remove(struct hv_device *hdev)
> >  	hv_put_dom_num(hbus->bridge->domain_nr);
> >  
> >  	kfree(hbus);
> > -	return ret;
> >  }
> >  
> >  static int hv_pci_suspend(struct hv_device *hdev)
> > diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> > index 3c5b7e4227b2..02f9d1a6f4ac 100644
> > --- a/drivers/scsi/storvsc_drv.c
> > +++ b/drivers/scsi/storvsc_drv.c
> > @@ -2092,7 +2092,7 @@ static int storvsc_change_queue_depth(struct scsi_device *sdev, int queue_depth)
> >  	return scsi_change_queue_depth(sdev, queue_depth);
> >  }
> >  
> > -static int storvsc_remove(struct hv_device *dev)
> > +static void storvsc_remove(struct hv_device *dev)
> >  {
> >  	struct storvsc_device *stor_device = hv_get_drvdata(dev);
> >  	struct Scsi_Host *host = stor_device->host;
> > @@ -2108,8 +2108,6 @@ static int storvsc_remove(struct hv_device *dev)
> >  	scsi_remove_host(host);
> >  	storvsc_dev_remove(dev);
> >  	scsi_host_put(host);
> > -
> > -	return 0;
> >  }
> >  
> >  static int storvsc_suspend(struct hv_device *hv_dev)
> > diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> > index c08a6cfd119f..20d9762331bd 100644
> > --- a/drivers/uio/uio_hv_generic.c
> > +++ b/drivers/uio/uio_hv_generic.c
> > @@ -355,20 +355,19 @@ hv_uio_probe(struct hv_device *dev,
> >  	return ret;
> >  }
> >  
> > -static int
> > +static void
> >  hv_uio_remove(struct hv_device *dev)
> >  {
> >  	struct hv_uio_private_data *pdata = hv_get_drvdata(dev);
> >  
> >  	if (!pdata)
> > -		return 0;
> > +		return;
> >  
> >  	sysfs_remove_bin_file(&dev->channel->kobj, &ring_buffer_bin_attr);
> >  	uio_unregister_device(&pdata->info);
> >  	hv_uio_cleanup(dev, pdata);
> >  
> >  	vmbus_free_ring(dev->channel);
> > -	return 0;
> >  }
> >  
> >  static struct hv_driver hv_uio_drv = {
> > diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
> > index 3ce746a46179..cfa6a7c1eeb3 100644
> > --- a/drivers/video/fbdev/hyperv_fb.c
> > +++ b/drivers/video/fbdev/hyperv_fb.c
> > @@ -1240,8 +1240,7 @@ static int hvfb_probe(struct hv_device *hdev,
> >  	return ret;
> >  }
> >  
> > -
> > -static int hvfb_remove(struct hv_device *hdev)
> > +static void hvfb_remove(struct hv_device *hdev)
> >  {
> >  	struct fb_info *info = hv_get_drvdata(hdev);
> >  	struct hvfb_par *par = info->par;
> > @@ -1262,8 +1261,6 @@ static int hvfb_remove(struct hv_device *hdev)
> >  
> >  	hvfb_putmem(hdev, info);
> >  	framebuffer_release(info);
> > -
> > -	return 0;
> >  }
> >  
> >  static int hvfb_suspend(struct hv_device *hdev)
> > diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> > index 85f7c5a63aa6..cd5cb9f6fae0 100644
> > --- a/include/linux/hyperv.h
> > +++ b/include/linux/hyperv.h
> > @@ -1273,7 +1273,7 @@ struct hv_driver {
> >  	} dynids;
> >  
> >  	int (*probe)(struct hv_device *, const struct hv_vmbus_device_id *);
> > -	int (*remove)(struct hv_device *);
> > +	void (*remove)(struct hv_device *dev);
> 
> nitpick for consistency from previous version
> 
> void (*remove)(struct hv_device *);

In that way, checkpatch.pl will complain:

$ ./scripts/checkpatch.pl 0001-Drivers-hv-Make-remove-callback-of-hyperv-driver-voi.patch
WARNING: function definition argument 'struct hv_device *' should also have an identifier name
#288: FILE: include/linux/hyperv.h:1276:
+	void (*remove)(struct hv_device *);

total: 0 errors, 1 warnings, 0 checks, 209 lines checked

Thanks,
            Dawei

> 
> 
> >  	void (*shutdown)(struct hv_device *);
> >  
> >  	int (*suspend)(struct hv_device *);
> > diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
> > index 59c3e2697069..7cb1a9d2cdb4 100644
> > --- a/net/vmw_vsock/hyperv_transport.c
> > +++ b/net/vmw_vsock/hyperv_transport.c
> > @@ -879,13 +879,11 @@ static int hvs_probe(struct hv_device *hdev,
> >  	return 0;
> >  }
> >  
> > -static int hvs_remove(struct hv_device *hdev)
> > +static void hvs_remove(struct hv_device *hdev)
> >  {
> >  	struct vmbus_channel *chan = hdev->channel;
> >  
> >  	vmbus_close(chan);
> > -
> > -	return 0;
> >  }
> >  
> >  /* hv_sock connections can not persist across hibernation, and all the hv_sock
> 
