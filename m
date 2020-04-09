Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80EED1A3830
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Apr 2020 18:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDIQnd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Apr 2020 12:43:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35890 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgDIQnd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Apr 2020 12:43:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id d202so444905wmd.1;
        Thu, 09 Apr 2020 09:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GqsW4NplX15N8qX+8fVspcv31iYa9ZYqvFm21P/uzwY=;
        b=IxSi3nKjpYfYIZLIeYjg1JAcS/ySWj2Y+xAT5KsrMrzDsWAVToiuImAibwTXDzi1eX
         LkXO7IWdsbQ0jbXxQSVThCPWOdNIzDbpekF6KE4h8TtCmZ3piKUYKne8buozPH9jphUv
         G8euP7RR12C/qyxFDS9Xv3He63tusu3mQ+S2z0PBRUjoiR55wZ8U3/e5sdhAJsUvU+7g
         xPWzpdCtT3xHgvCIVQR7QuVOW2dJw5BkY7WlXtyKFwXIl9Eouf8sngNCW+pL+cr11xV3
         nYe6x+loB2FXgXEkXwe7Kc5p4pzyBChmWlSC5YgJozPMg1llfgv1Ft8HGMeeajf9ikgp
         e60A==
X-Gm-Message-State: AGi0PuZVZIVJT1i3lKdhKfkg8GVjrwqjsPRm+nbczdrGiclWRtwE/bWU
        4/ZOBnaTYqxEUY/exTqxK4A=
X-Google-Smtp-Source: APiQypI0XKG4vTskNbZYqy+3guwd9G+vGhZsx3YHrh6ec78LRBC87cZaW5haKsZ2Z5ug+a0JJbAaig==
X-Received: by 2002:a05:600c:210c:: with SMTP id u12mr759394wml.135.1586450610513;
        Thu, 09 Apr 2020 09:43:30 -0700 (PDT)
Received: from debian (44.142.6.51.dyn.plus.net. [51.6.142.44])
        by smtp.gmail.com with ESMTPSA id v9sm31279066wrv.18.2020.04.09.09.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 09:43:29 -0700 (PDT)
Date:   Thu, 9 Apr 2020 17:43:28 +0100
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: Re: [PATCH v2 0/5] Drivers: hv: cleanup VMBus messages handling
Message-ID: <20200409164328.qy4aqvgzayhorzjp@debian>
References: <20200406104154.45010-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406104154.45010-1-vkuznets@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Apr 06, 2020 at 12:41:49PM +0200, Vitaly Kuznetsov wrote:
> A small cleanup series mostly aimed at sanitizing memory we pass to
> message handlers: not passing garbage/lefrtovers from other messages
> and making sure we fail early when hypervisor misbehaves.
> 
> No (real) functional change intended.
> 
> Changes since v1:
> - Check that the payload size specified by the host is <= 240 bytes
> - Add Michael's R-b tags.
> 
> Vitaly Kuznetsov (5):
>   Drivers: hv: copy from message page only what's needed
>   Drivers: hv: allocate the exact needed memory for messages
>   Drivers: hv: avoid passing opaque pointer to vmbus_onmessage()
>   Drivers: hv: make sure that 'struct vmbus_channel_message_header'
>     compiles correctly
>   Drivers: hv: check VMBus messages lengths

Queued. Thanks.

Wei.
