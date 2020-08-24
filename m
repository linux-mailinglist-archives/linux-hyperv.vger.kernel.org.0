Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F98125002A
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Aug 2020 16:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgHXOv4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 24 Aug 2020 10:51:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55436 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHXOvu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 24 Aug 2020 10:51:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id a65so5024166wme.5;
        Mon, 24 Aug 2020 07:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O4cLVSqOMnOhp/c9xdR6/wn9sgaEYCRgjATf4lKdj3E=;
        b=Dh+AHgS84smt6nkal3Wp6PUX+Ykgtj16BY/JGRGXqvW16zL0moWrNgsYfduqAUOHvM
         S00rrLjUOw/tMud9y4uxqIDEE2YLdnKTDBoYptxBAHsixAItenEW7HHAU1e64PDkGb/Q
         vRQavpu9h+P/wh0rt8ICkUjR+ZRAVeGR9akvhkdgEbSgxem5RZLHJ+NTYX0w9Vu1Pd4G
         VUd5IGw60FZ9m4aQgzwk8N0o3YITdpXswWLgbCFRGS8pCMLB17rd90d9hRD9k53Q9iai
         So4wuaZdWgP6VRUdHV7n8VyzkcSuqV4kbUEgYFQtbttvIDOFj/SAU4LlIFAPYbUY1iQ8
         C7Uw==
X-Gm-Message-State: AOAM531emv8Lk/TO3ydbo3Y7unbwnE2jNdWcukFkcxBPTeBSm3DIKp08
        8oK8GEybyzAVgadrNDtX3Uw=
X-Google-Smtp-Source: ABdhPJxj7zoJvnH4N8h0Z0iobV/dlXmirjozUHHMUl5VrYCtTe0OCkH1v1hqdBKjONcFSOu+bNBb0Q==
X-Received: by 2002:a1c:7c0d:: with SMTP id x13mr5802507wmc.164.1598280708667;
        Mon, 24 Aug 2020 07:51:48 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a3sm25250217wme.34.2020.08.24.07.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 07:51:48 -0700 (PDT)
Date:   Mon, 24 Aug 2020 14:51:47 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vineeth Pillai <viremana@linux.microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hv_utils: drain the timesync packets on
 onchannelcallback
Message-ID: <20200824145146.uhndpqazw4tsry6o@liuwe-devbox-debian-v2>
References: <20200821152849.99517-1-viremana@linux.microsoft.com>
 <20200822085504.ryowfhild67ktu57@liuwe-devbox-debian-v2>
 <4780afef-76ab-d4c6-5d9f-8e49875419b4@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4780afef-76ab-d4c6-5d9f-8e49875419b4@linux.microsoft.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Aug 23, 2020 at 08:15:41AM -0400, Vineeth Pillai wrote:
> 
> > Typo "packaet".
> > 
> > No need to resend. I can fix this while committing this patch.
> 
> Thanks Wei.
> 
> 

Applied to hyperv-fixes. Thanks.
