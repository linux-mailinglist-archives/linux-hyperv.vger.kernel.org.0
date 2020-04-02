Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A53519C552
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2020 17:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388979AbgDBPDA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 2 Apr 2020 11:03:00 -0400
Received: from mail-m974.mail.163.com ([123.126.97.4]:39452 "EHLO
        mail-m974.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388744AbgDBPDA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 2 Apr 2020 11:03:00 -0400
X-Greylist: delayed 926 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Apr 2020 11:02:55 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=NoHn/
        1xOFDtjQlisPK6W+3xORWJgJCeu5w3FV4CHJCs=; b=K0tgwe57xku+qga/Akr/Z
        TN0Izw/eNyFbM1xxrErCoZNFbKKXy7HyBBQzBss1un/LwT2vQYE41O63Jlj4o371
        Bj93sAOqAyyYwtLmu9zwlMk6s9eSNljPjIEicC3FMHaCdkkEVZoHrh5q3/Fi7j04
        HTHsNJVVS4NCFeAqg7TzG8=
Received: from [10.10.140.154] (unknown [167.220.255.26])
        by smtp4 (Coremail) with SMTP id HNxpCgDHNjXd+oVefycuAA--.100S2;
        Thu, 02 Apr 2020 22:47:10 +0800 (CST)
Subject: Re: [EXTERNAL] [PATCH 1/5] Drivers: hv: copy from message page only
 what's needed
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
References: <20200401103638.1406431-1-vkuznets@redhat.com>
 <20200401103638.1406431-2-vkuznets@redhat.com>
From:   163 <freedomsky1986@163.com>
Message-ID: <3ed15a02-0b86-0ec1-6daf-df94f8fc6ba5@163.com>
Date:   Thu, 2 Apr 2020 22:46:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401103638.1406431-2-vkuznets@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: HNxpCgDHNjXd+oVefycuAA--.100S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF47Gr1xZw1UKw17Cr18uFg_yoW8Cr4kpa
        yakF4Yyrs5AFWIvwn7Kw4UCFW5Wwn2gFW7Grs5u34DZ3W5XFy7ta4UGryq9FZrtr1kua47
        Zr4qvFn5CF1DWrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jRnm_UUUUU=
X-Originating-IP: [167.220.255.26]
X-CM-SenderInfo: piuhvv5rpvy5arzylqqrwthudrp/1tbiTg75s1UDCxrjEAAAs+
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 4/1/2020 6:36 PM, Vitaly Kuznetsov wrote:
> Hyper-V Interrupt Message Page (SIMP) has 16 256-byte slots for
> messages. Each message comes with a header (16 bytes) which specifies the
> payload length (up to 240 bytes). vmbus_on_msg_dpc(), however, doesn't
> look at the real message length and copies the whole slot to a temporary
> buffer before passing it to message handlers. This is potentially dangerous
> as hypervisor doesn't have to clean the whole slot when putting a new
> message there and a message handler can get access to some data which
> belongs to a previous message.
> 
> Note, this is not currently a problem because all message handlers are
> in-kernel but eventually we may e.g. get this exported to userspace.
> 
> Note also, that this is not a performance critical path: messages (unlike
> events) represent rare events so it doesn't really matter (from performance
> point of view) if we copy too much.
> 
> Fix the issue by taking into account the real message length. The temporary
> buffer allocated by vmbus_on_msg_dpc() remains fixed size for now.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>   drivers/hv/vmbus_drv.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 029378c27421..2b5572146358 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1043,7 +1043,8 @@ void vmbus_on_msg_dpc(unsigned long data)
>   			return;
>   
>   		INIT_WORK(&ctx->work, vmbus_onmessage_work);
> -		memcpy(&ctx->msg, msg, sizeof(*msg));
> +		memcpy(&ctx->msg, msg, sizeof(msg->header) +
> +		       msg->header.payload_size);
>   

Hi Vitaly:
      I think we still need to check whether the payload_size passed from
Hyper-V is valid or not here to avoid cross-border issue before doing
copying.

