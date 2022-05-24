Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBAD532CBD
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 May 2022 16:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238499AbiEXO6R (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 May 2022 10:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238509AbiEXO6H (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 May 2022 10:58:07 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FA784A0A
        for <linux-hyperv@vger.kernel.org>; Tue, 24 May 2022 07:58:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o13-20020a17090a9f8d00b001df3fc52ea7so2316878pjp.3
        for <linux-hyperv@vger.kernel.org>; Tue, 24 May 2022 07:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=59h+/JtC4RYKxypheoAK7303udAODVE+57EhQyN6vP0=;
        b=16OnVO6iW3uBlhstKGAYceusMdbClJ5HXjOQUcG1pXBgjCDXa/htakU4WtIFDs9zWe
         ZHZ+fe0EkOmQ4sYrLb6bRBR+d6QVPO4gsWeMnANFVXHuwBvE2Ya9ahhCKKi/Jinn0VAf
         S3knjWzVw5U86Ie92YyUbZnvm+SekUi5bJbOlJ3f/XcBE84JNTn0T4mJKcu9UucBpGJH
         ppCvq7JdX9DFn05CNxLY1h1sCS1+pEKccd4XMtPAkWvUyFGAEojfxrNc/kRIxYsYYYpb
         XI1scX1upf5iwZJrUY3J8PSG522BWduccIJkotwA38/f3FLX5VU7jr9csgFh0NEiAUav
         EMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=59h+/JtC4RYKxypheoAK7303udAODVE+57EhQyN6vP0=;
        b=0YtP8x9nmcaVlvaUv1SElSB+5SHlC9bhEpfyduq+QOoGEq/0VLCUYjnEsNfoUxrfZz
         jPwOR5RzX2V118i7v9kDryb9CNIy5Q1pLYytw4F0YYNlGYOh1a+FSiKdHHraW2KLcfom
         uohHd7Yb3udTick2EhmRUcJJ5y1TLNfCXGHWmyQroWnP6tF/Ef4anrj/n5lesdxIblyY
         0S4uywdrm506g3AAFKUPmv8RC7UOk3IGiIErdxsxr6yFEMQggqFQQVkm5SnbrMv4VMsY
         B1NtlAmjk1v7aArsnsQICMJ4KLY82bDdnGyhh+VjWeJAQtnfFzQGay7scxqehGyktu/f
         qg3A==
X-Gm-Message-State: AOAM533V//gomSxzJEveLSBFBxc7hkc+rrnHWsDy8t0ByuO/8PQrUUEJ
        tVNgkCaDYv7jUzFZSpSyi0YmdPnzDYOmBg==
X-Google-Smtp-Source: ABdhPJzjpBsndUgbSa91pwj1VI6AlKcQYTsmeBGZnwUsrJT9K0Q2Tl+VCrWmRu4MyI99wRONBBt+Tg==
X-Received: by 2002:a17:90a:764b:b0:1df:58f2:784c with SMTP id s11-20020a17090a764b00b001df58f2784cmr4838071pjl.122.1653404285650;
        Tue, 24 May 2022 07:58:05 -0700 (PDT)
Received: from hermes.local (204-195-112-199.wavecable.com. [204.195.112.199])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902f78d00b0015e8d4eb242sm7230444pln.140.2022.05.24.07.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 07:58:05 -0700 (PDT)
Date:   Tue, 24 May 2022 07:58:02 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Saurabh Singh Sengar <ssengar@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v3] scsi: storvsc: Removing Pre Win8 related logic
Message-ID: <20220524075802.020917e0@hermes.local>
In-Reply-To: <DM5PR2101MB1030ED63885693A748892F26CCD79@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <1653392516-9233-1-git-send-email-ssengar@linux.microsoft.com>
        <DM5PR2101MB1030ED63885693A748892F26CCD79@DM5PR2101MB1030.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


> 
> The latest storvsc code has already removed the support for windows 7 and
> earlier. There is still some code logic reamining which is there to support
> pre Windows 8 OS. This patch removes these stale logic.
> This patch majorly does three things :
> 
> 1. Removes vmscsi_size_delta and its logic, as the vmscsi_request struct is
> same for all the OS post windows 8 there is no need of delta.
> 2. Simplify sense_buffer_size logic, as there is single buffer size for
> all the post windows 8 OS.
> 3. Embed the vmscsi_win8_extension structure inside the vmscsi_request,
> as there is no separate handling required for different OS.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> v3 : Removed pre win8 macros:
> 	- POST_WIN7_STORVSC_SENSE_BUFFER_SIZE
> 	- VMSTOR_PROTO_VERSION_WIN6
> 	- VMSTOR_PROTO_VERSION_WIN7
> 
>  drivers/scsi/storvsc_drv.c | 152 ++++++++++---------------------------
>  1 file changed, 40 insertions(+), 112 deletions(-)
> 
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 5585e9d30bbf..66d9adb5487f 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -55,8 +55,6 @@
>  #define VMSTOR_PROTO_VERSION(MAJOR_, MINOR_)	((((MAJOR_) & 0xff) << 8) | \
>  						(((MINOR_) & 0xff)))
>  
> -#define VMSTOR_PROTO_VERSION_WIN6	VMSTOR_PROTO_VERSION(2, 0)
> -#define VMSTOR_PROTO_VERSION_WIN7	VMSTOR_PROTO_VERSION(4, 2)
>  #define VMSTOR_PROTO_VERSION_WIN8	VMSTOR_PROTO_VERSION(5, 1)
>  #define VMSTOR_PROTO_VERSION_WIN8_1	VMSTOR_PROTO_VERSION(6, 0)
>  #define VMSTOR_PROTO_VERSION_WIN10	VMSTOR_PROTO_VERSION(6, 2)

Keeping the macros is ok, could help with diagnosing some future problem?

> @@ -136,19 +134,15 @@ struct hv_fc_wwn_packet {
>   */
>  #define STORVSC_MAX_CMD_LEN			0x10
>  
> -#define POST_WIN7_STORVSC_SENSE_BUFFER_SIZE	0x14
> -#define PRE_WIN8_STORVSC_SENSE_BUFFER_SIZE	0x12
> -
>  #define STORVSC_SENSE_BUFFER_SIZE		0x14
>  #define STORVSC_MAX_BUF_LEN_WITH_PADDING	0x14
>  
>  /*
> - * Sense buffer size changed in win8; have a run-time
> - * variable to track the size we should use.  This value will
> - * likely change during protocol negotiation but it is valid
> - * to start by assuming pre-Win8.
> + * Sense buffer size was differnt pre win8 but those OS are not supported any
> + * more starting 5.19 kernel. This results in to supporting a single value from
> + * win8 onwards.
>   */

Spelling s/differnt/different/
Also the wording has become awkward.

Suggest simpler, shorter comment and make it cons.

/* Sense buffer size is the same for all versions since Windows 8 */
static const int sense_buffer_size = STORVSC_SENSE_BUFFER_SIZE;


> -static int sense_buffer_size = PRE_WIN8_STORVSC_SENSE_BUFFER_SIZE;
> +static int sense_buffer_size = STORVSC_SENSE_BUFFER_SIZE;
>
