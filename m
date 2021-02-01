Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5A330AEC4
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Feb 2021 19:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhBASLW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 1 Feb 2021 13:11:22 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:44150 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhBASLW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Feb 2021 13:11:22 -0500
Received: by mail-wr1-f51.google.com with SMTP id d16so17619377wro.11;
        Mon, 01 Feb 2021 10:11:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ClgzRBvBB4JWauaZ8oQyQhZpGkEOEy03oma3zj0ET0A=;
        b=S/JnBHxhDo//7G2IFx37FEFfimckFst4Q+xno9F4GvKBBzOGB4+AkBpBu0YkKr4yYb
         Yx/kQzuefdAKvGymPeD2iQ9CuYFyhFHDNp2kSKCujXIyhis8ysdzsXmf9c92Xg5Bojiw
         dh2PwhtXJho0ORz2Mf1dm7STqeZG52n6hcVPIDTfJHk/EkPpK6Gw0r9IishzU3KzeDKD
         ayUk8qGAPYnbmiXXCxNXCnFmJ1rrDgjR0WMTzk+n18QPc3AaCfLa8fA+aGvP9Q1BXy0g
         BTziJZDIXq5NXdB/F+0RNEbB+H4hrdcWgM9quZ7RbJ/yhKTnz4xIeSNVuA3Nf1p0ux1I
         7u8A==
X-Gm-Message-State: AOAM532GZ+TB248EGdYGg3+dPa1NdrPL+WzcpsJ+gmrM3W8zv1OIE9Ml
        joCE4WhFzmoYHWQes3ygDMFZo5frALA=
X-Google-Smtp-Source: ABdhPJwWGpc24hq9Aq7iPEUdAS/iyp984KksCy4GUEl7uQ/0sUTQNxMiL1jtdNKHffUziBbA9K+Gjg==
X-Received: by 2002:adf:9226:: with SMTP id 35mr3958594wrj.408.1612203039901;
        Mon, 01 Feb 2021 10:10:39 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id q6sm26534256wrw.43.2021.02.01.10.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:10:39 -0800 (PST)
Date:   Mon, 1 Feb 2021 18:10:38 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH][next] hv: hyperv.h: Replace one-element array with
 flexible-array in struct icmsg_negotiate
Message-ID: <20210201181038.2frt7vftww63tevv@liuwe-devbox-debian-v2>
References: <20210201174334.GA171933@embeddedor>
 <MWHPR21MB15932BA4162D2DE1877C65C6D7B69@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15932BA4162D2DE1877C65C6D7B69@MWHPR21MB1593.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Feb 01, 2021 at 05:56:06PM +0000, Michael Kelley wrote:
> From: Gustavo A. R. Silva <gustavoars@kernel.org> Sent: Monday, February 1, 2021 9:44 AM
[...]
> >  struct shutdown_msg_data {
> > --
> > 2.27.0
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-next. Thanks.

Wei.
