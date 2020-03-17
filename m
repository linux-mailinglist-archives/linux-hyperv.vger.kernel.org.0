Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDE1188C35
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2020 18:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgCQRf7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Mar 2020 13:35:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35488 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgCQRf7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Mar 2020 13:35:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so6208747wru.2;
        Tue, 17 Mar 2020 10:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=z1FYoq7S+h9Cgu9l0oBNg+vW7ywbgvdSrh8VbOK3SfM=;
        b=oxAW0Nup0YR+8xX8Qb6Xa8HlTGx9A0Saxe8Ip00Qg/yqT1QSrV54/VHC1D7GNayV5s
         HIUbwydozvc4P9qL+fnYkCDW+PY1i40QB67XA1VRt08FJUlnOAIB3Kdynosj+tPOLQ8n
         zo7gXef6ziu4mCirKdyvuqx7ImBLXXZyGNkOb/nVP+aIduGy7lADrrwNiKokaQaDyy0k
         u/p2y86uzL55Ra568u914P95nh9rd80n+4En4F0eFl31TIkSfgDD1n7vBNGhnNPUKMWe
         VveZZvRvrBwqs5cDz7c5zgA87p+JUkNoXots1pQtT0pdtOr7NVJ/qz1M+C1m4B+emIg2
         Si0g==
X-Gm-Message-State: ANhLgQ1HVwWj4aBX189zvpNX0CDUiOv0vxv82V5MBIrUeLxWuXl27LZK
        YHWame/q+rjc9lIzOaNW8sg=
X-Google-Smtp-Source: ADFU+vsRnkfec8PavottvdVxNiDc4mWmBjPI9jouBKRRcnyVA5ONRdkNDrTETtUY3kl/zdcooYiSvQ==
X-Received: by 2002:adf:a313:: with SMTP id c19mr58403wrb.411.1584466556747;
        Tue, 17 Mar 2020 10:35:56 -0700 (PDT)
Received: from debian (41.142.6.51.dyn.plus.net. [51.6.142.41])
        by smtp.gmail.com with ESMTPSA id g2sm5779960wrs.42.2020.03.17.10.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 10:35:56 -0700 (PDT)
Date:   Tue, 17 Mar 2020 17:35:53 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     ltykernel@gmail.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH 0/4] x86/Hyper-V: Unload vmbus channel in hv panic
 callback
Message-ID: <20200317173553.jerf6gjtaotqjbac@debian>
References: <20200317132523.1508-1-Tianyu.Lan@microsoft.com>
 <20200317132523.1508-2-Tianyu.Lan@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200317132523.1508-2-Tianyu.Lan@microsoft.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 17, 2020 at 06:25:20AM -0700, ltykernel@gmail.com wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> Customer reported Hyper-V VM still responded network traffic
> ack packets after kernel panic with kernel parameter "panic=0”.
> This becauses vmbus driver interrupt handler still works
> on the panic cpu after kernel panic. Panic cpu falls into
> infinite loop of panic() with interrupt enabled at that point.
> Vmbus driver can still handle network traffic.
> 
> This confuses remote service that the panic system is still
> alive when it gets ack packets. Unload vmbus channel in hv panic
> callback and fix it.
> 
> vmbus_initiate_unload() maybe double called during panic process
> (e.g, hyperv_panic_event() and hv_crash_handler()). So check
> and set connection state in vmbus_initiate_unload() to resolve
> reenter issue.
> 
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c |  5 +++++
>  drivers/hv/vmbus_drv.c    | 17 +++++++++--------
>  2 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 0370364169c4..893493f2b420 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -839,6 +839,9 @@ void vmbus_initiate_unload(bool crash)
>  {
>  	struct vmbus_channel_message_header hdr;
>  
> +	if (vmbus_connection.conn_state == DISCONNECTED)
> +		return;
> +
>  	/* Pre-Win2012R2 hosts don't support reconnect */
>  	if (vmbus_proto_version < VERSION_WIN8_1)
>  		return;
> @@ -857,6 +860,8 @@ void vmbus_initiate_unload(bool crash)
>  		wait_for_completion(&vmbus_connection.unload_event);
>  	else
>  		vmbus_wait_for_unload();
> +
> +	vmbus_connection.conn_state = DISCONNECTED;

This is only set at the end of the function.  I don't see how this solve
the re-entrant issue with the check at the beginning. Do I miss anything
here?

Maybe this function should check and set the state to
DISCONNECTING/DISCONNECTED at the beginning of this function?

Wei.
