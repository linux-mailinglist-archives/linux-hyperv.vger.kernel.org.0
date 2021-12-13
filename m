Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6589471F31
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Dec 2021 02:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhLMBrT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 12 Dec 2021 20:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhLMBrT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 12 Dec 2021 20:47:19 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28348C06173F
        for <linux-hyperv@vger.kernel.org>; Sun, 12 Dec 2021 17:47:19 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id l25so47693955eda.11
        for <linux-hyperv@vger.kernel.org>; Sun, 12 Dec 2021 17:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4nOYAJzYhuF84QGCTf1xLcy4wJW0sNCp4o2QyvIVjik=;
        b=RtsdNhVLL4A59oP9uomY8+avNw4MUOCm7FXCyZdFlMcBg28LUMk+XvxhUT/KPzJ3uj
         BbgMgXo5xuddXxoeEXOVP5YDWC0iXYxea59FsinomTa/d6PVg+yNyna1gf7KB7NWNZnc
         03cp0oe0aYUGcdwjm2pQdtA54UB6f9TgSwsuC6WjM9e3A95ye2fNkOSGb7imb1GUvuG+
         TQOxiaIFkhtmGQCxiaDMpKCGDMU5lBhuaEjiJpiJz+JBAaLRHCcYyDrFIf7SqvYKCsHc
         yKNSSjj4pioJgKAkla76Z9WEzVrKxTYwv6ehvXLdbzz+ZRwwDgx6gwwn225bNiztCQjl
         A8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4nOYAJzYhuF84QGCTf1xLcy4wJW0sNCp4o2QyvIVjik=;
        b=MhJQwYGESo+STKHFGz8MprEfiGFq61pcjoXvc6ArSkWBCwE0F1hGJHI/StXSvP8HP1
         q7N2KqRxm1a4iy4XagYmY9DMwbFCHRmjOm7PrEa5c/5AL/nedY7ngpKheDTnpqnyCeJQ
         t19NpyGr/6JUT4jY6TxGbhPYTfmch7c/KTveY2KlK6p4v51vaUBCJmfsZFaBVcU84nI3
         FjjksL2I/vsTkPEf1qbDBCXnye7dS/wPDoxPD71iaWoCV43ket4awGnpFxqkn2VoUyBo
         XwVDtjXbUjokpIK2zL8OJWaXPmjttQ5O2OeUkCbpUdg5db7M5JAZvjcKvx8rXdTLQKDq
         j6UA==
X-Gm-Message-State: AOAM531JHTDj3gefe/fyOFjLvzHrAkcrvhcCFmHKhdxuxchVVedUnTNz
        Dg9SDEdka3FTtSW9xhFZJCY=
X-Google-Smtp-Source: ABdhPJxgtBs5dNikuPUHPDjWD1Z/x04gXRAqQqOEY//il64j600YA/gFMxUbFtw33hmM0+05niW2YQ==
X-Received: by 2002:a17:907:86a6:: with SMTP id qa38mr38762101ejc.286.1639360037685;
        Sun, 12 Dec 2021 17:47:17 -0800 (PST)
Received: from anparri (host-79-23-180-143.retail.telecomitalia.it. [79.23.180.143])
        by smtp.gmail.com with ESMTPSA id h7sm5399459edb.89.2021.12.12.17.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 17:47:17 -0800 (PST)
Date:   Mon, 13 Dec 2021 02:47:09 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Yanming Liu <yanminglr@gmail.com>
Cc:     linux-hyperv@vger.kernel.org, Andres Beltran <lkmlabelt@gmail.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] hv: account for packet descriptor in maximum packet size
Message-ID: <20211213014709.GA2316@anparri>
References: <20211212121326.215377-1-yanminglr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211212121326.215377-1-yanminglr@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Yanming,

[...]

> Specifically, in hv_balloon I have observed of a dm_unballoon_request
> message of 4096 bytes being truncated to 4080 bytes. When the driver
> tries to read next packet it starts from the wrong read_index, receives
> garbage and prints a lot of "Unhandled message: type: <garbage>" in
> dmesg.

To make sure I understand your observations: Can you please print/share the
values of (desc->len8 << 3) and (desc->offset8 << 3) for such a "truncated"
packet, say, right after the

	desc = hv_pkt_iter_first(channel);

in hv_ringbuffer_read()?  Also, it'd be interesting to know whether any of
the two validations on pkt_len and pkt_offset in hv_pkt_iter_first() fails
(so that pkt_len/pkt_offset get updated in there).

Thanks,
  Andrea
